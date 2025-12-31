# Terraform configuration for Docker resources
# This project is used to test Terraform CI/CD workflows

terraform {
  required_version = ">= 1.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Docker network for the application
resource "docker_network" "app_network" {
  name   = var.network_name
  driver = "bridge"

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "managed_by"
    value = "terraform"
  }
}

# Pull the base image
resource "docker_image" "nginx" {
  name         = "nginx:${var.nginx_version}"
  keep_locally = true
}

resource "docker_image" "redis" {
  name         = "redis:${var.redis_version}"
  keep_locally = true
}

# Redis container for caching
resource "docker_container" "redis" {
  name  = "${var.app_name}-redis"
  image = docker_image.redis.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "managed_by"
    value = "terraform"
  }

  restart = "unless-stopped"

  ports {
    internal = 6379
    external = var.redis_port
  }
}

# Nginx container as web server
resource "docker_container" "nginx" {
  name  = "${var.app_name}-nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "managed_by"
    value = "terraform"
  }

  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.nginx_port
  }

  volumes {
    host_path      = var.nginx_config_path
    container_path = "/etc/nginx/conf.d"
    read_only      = true
  }
}
