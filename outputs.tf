# Output definitions

output "instance_id" {
  description = "Unique instance identifier"
  value       = random_id.suffix.hex
}

output "config_directory" {
  description = "Path to configuration directory"
  value       = "${path.module}/output/${var.environment}"
}

output "app_config_path" {
  description = "Path to application config file"
  value       = local_file.app_config.filename
}

output "db_config_path" {
  description = "Path to database config file"
  value       = local_file.db_config.filename
}

output "cache_config_path" {
  description = "Path to cache config file"
  value       = local_file.cache_config.filename
}

output "deployment_summary" {
  description = "Deployment summary"
  value = {
    app_name    = var.app_name
    environment = var.environment
    version     = var.app_version
    instance_id = random_id.suffix.hex
  }
}
