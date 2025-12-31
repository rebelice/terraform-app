# Terraform configuration for testing CI/CD workflows
# Using local and null providers (no external dependencies)

terraform {
  required_version = ">= 1.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# Generate random suffix for unique resource names
resource "random_id" "suffix" {
  byte_length = 4
}

# Application configuration file
resource "local_file" "app_config" {
  filename = "${path.module}/output/${var.environment}/app-config.json"
  content = jsonencode({
    app_name    = var.app_name
    environment = var.environment
    version     = var.app_version
    created_at  = timestamp()
    instance_id = random_id.suffix.hex
    settings = {
      debug_mode  = var.debug_mode
      log_level   = var.log_level
      max_workers = var.max_workers
    }
  })

  file_permission = "0644"
}

# Database configuration file
resource "local_file" "db_config" {
  filename = "${path.module}/output/${var.environment}/db-config.json"
  content = jsonencode({
    host      = var.db_host
    port      = var.db_port
    database  = var.db_name
    user      = var.db_user
    pool_size = var.db_pool_size
  })

  file_permission = "0600"
}

# Cache configuration file
resource "local_file" "cache_config" {
  filename = "${path.module}/output/${var.environment}/cache-config.json"
  content = jsonencode({
    host = var.redis_host
    port = var.redis_port
    ttl  = var.cache_ttl
  })

  file_permission = "0644"
}

# Null resource for triggering provisioners
resource "null_resource" "app_deployment" {
  triggers = {
    config_hash = sha256(local_file.app_config.content)
    db_hash     = sha256(local_file.db_config.content)
    cache_hash  = sha256(local_file.cache_config.content)
  }

  provisioner "local-exec" {
    command = "echo 'Deployment triggered for ${var.app_name} in ${var.environment}'"
  }
}

# Outputs directory structure
resource "local_file" "readme" {
  filename = "${path.module}/output/${var.environment}/README.md"
  content  = <<-EOT
    # ${var.app_name} Configuration

    Environment: ${var.environment}
    Generated: ${timestamp()}

    ## Files
    - app-config.json: Application settings
    - db-config.json: Database connection
    - cache-config.json: Redis cache settings
  EOT

  file_permission = "0644"
}
