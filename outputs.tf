# Output definitions

output "network_id" {
  description = "ID of the Docker network"
  value       = docker_network.app_network.id
}

output "network_name" {
  description = "Name of the Docker network"
  value       = docker_network.app_network.name
}

output "nginx_container_id" {
  description = "ID of the Nginx container"
  value       = docker_container.nginx.id
}

output "nginx_url" {
  description = "URL to access Nginx"
  value       = "http://localhost:${var.nginx_port}"
}

output "redis_container_id" {
  description = "ID of the Redis container"
  value       = docker_container.redis.id
}

output "redis_url" {
  description = "URL to connect to Redis"
  value       = "redis://localhost:${var.redis_port}"
}

output "postgres_container_id" {
  description = "ID of the PostgreSQL container"
  value       = docker_container.postgres.id
}

output "postgres_url" {
  description = "URL to connect to PostgreSQL"
  value       = "postgresql://${var.postgres_user}:****@localhost:${var.postgres_port}/${var.postgres_db}"
}
