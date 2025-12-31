# Variable definitions for the infrastructure configuration

# Application settings
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "myapp"
}

variable "app_version" {
  description = "Application version"
  type        = string
  default     = "1.0.0"
}

variable "debug_mode" {
  description = "Enable debug mode"
  type        = bool
  default     = false
}

variable "log_level" {
  description = "Logging level"
  type        = string
  default     = "info"

  validation {
    condition     = contains(["debug", "info", "warn", "error"], var.log_level)
    error_message = "Log level must be one of: debug, info, warn, error."
  }
}

variable "max_workers" {
  description = "Maximum number of workers"
  type        = number
  default     = 4
}

# Database settings
variable "db_host" {
  description = "Database host"
  type        = string
  default     = "localhost"
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "app"
}

variable "db_pool_size" {
  description = "Database connection pool size"
  type        = number
  default     = 10
}

# Cache settings
variable "redis_host" {
  description = "Redis host"
  type        = string
  default     = "localhost"
}

variable "redis_port" {
  description = "Redis port"
  type        = number
  default     = 6379
}

variable "cache_ttl" {
  description = "Cache TTL in seconds"
  type        = number
  default     = 3600
}

# Monitoring settings
variable "metrics_enabled" {
  description = "Enable metrics collection"
  type        = bool
  default     = true
}

variable "metrics_endpoint" {
  description = "Metrics endpoint URL"
  type        = string
  default     = "/metrics"
}

variable "metrics_interval" {
  description = "Metrics collection interval in seconds"
  type        = number
  default     = 60
}

variable "alerting_enabled" {
  description = "Enable alerting"
  type        = bool
  default     = true
}

variable "alert_threshold" {
  description = "Alert threshold percentage"
  type        = number
  default     = 80
}
