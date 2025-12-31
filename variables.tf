# Variable definitions for the Docker infrastructure

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application name prefix for resources"
  type        = string
  default     = "myapp"
}

variable "network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "app-network"
}

variable "nginx_version" {
  description = "Nginx image version"
  type        = string
  default     = "alpine"
}

variable "redis_version" {
  description = "Redis image version"
  type        = string
  default     = "7-alpine"
}

variable "nginx_port" {
  description = "External port for Nginx"
  type        = number
  default     = 8080
}

variable "redis_port" {
  description = "External port for Redis"
  type        = number
  default     = 6379
}

variable "nginx_config_path" {
  description = "Path to Nginx configuration directory"
  type        = string
  default     = "/tmp/nginx-conf"
}

variable "postgres_version" {
  description = "PostgreSQL image version"
  type        = string
  default     = "15-alpine"
}

variable "postgres_port" {
  description = "External port for PostgreSQL"
  type        = number
  default     = 5432
}

variable "postgres_user" {
  description = "PostgreSQL user"
  type        = string
  default     = "app"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  default     = "secret"
  sensitive   = true
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "appdb"
}
