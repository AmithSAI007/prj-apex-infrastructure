// Cloud SQL PostgreSQL Variables

variable "project_id" {
  type        = string
  description = "The unique identifier for the GCP project for resource organization and billing."
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "project_region" {
  type        = string
  description = "The GCP region where the Cloud SQL instance will be deployed."
  validation {
    condition     = length(var.project_region) > 0
    error_message = "The project_region must be specified."
  }
}

variable "instance_name" {
  type        = string
  description = "The name of the Cloud SQL PostgreSQL instance."
  default     = "apex-dev-cloudsql-postgres"
  validation {
    condition     = length(var.instance_name) > 0 && length(var.instance_name) <= 95
    error_message = "The instance name must be between 1 and 95 characters."
  }
}

variable "database_name" {
  type        = string
  description = "The name of the default database to create."
  default     = "apex_db"
}

variable "tier" {
  type        = string
  description = "The machine type for the Cloud SQL instance (e.g., db-f1-micro, db-g1-small, db-n1-standard-1)."
  default     = "db-f1-micro"
}

variable "edition" {
  type        = string
  description = "The edition of the Cloud SQL instance (ENTERPRISE or ENTERPRISE_PLUS)."
  default     = "ENTERPRISE"
  validation {
    condition     = contains(["ENTERPRISE", "ENTERPRISE_PLUS"], var.edition)
    error_message = "The edition must be either ENTERPRISE or ENTERPRISE_PLUS."
  }
}

variable "availability_type" {
  type        = string
  description = "The availability type for the Cloud SQL instance (REGIONAL or ZONAL)."
  default     = "ZONAL"
  validation {
    condition     = contains(["REGIONAL", "ZONAL"], var.availability_type)
    error_message = "The availability_type must be either REGIONAL or ZONAL."
  }
}

variable "disk_size" {
  type        = number
  description = "The size of the disk in GB."
  default     = 10
  validation {
    condition     = var.disk_size >= 10
    error_message = "The disk_size must be at least 10 GB."
  }
}

variable "disk_type" {
  type        = string
  description = "The type of disk (PD_SSD or PD_HDD)."
  default     = "PD_SSD"
  validation {
    condition     = contains(["PD_SSD", "PD_HDD"], var.disk_type)
    error_message = "The disk_type must be either PD_SSD or PD_HDD."
  }
}

variable "backup_start_time" {
  type        = string
  description = "The start time of the backup window in UTC (HH:MM format)."
  default     = "03:00"
}

variable "maintenance_window_day" {
  type        = number
  description = "The day of the week for maintenance window (1=Monday, 7=Sunday, 0=No window)."
  default     = 7
  validation {
    condition     = var.maintenance_window_day >= 0 && var.maintenance_window_day <= 7
    error_message = "The maintenance_window_day must be between 0 and 7."
  }
}

variable "maintenance_window_hour" {
  type        = number
  description = "The hour of the day for maintenance window (0-23)."
  default     = 3
  validation {
    condition     = var.maintenance_window_hour >= 0 && var.maintenance_window_hour <= 23
    error_message = "The maintenance_window_hour must be between 0 and 23."
  }
}

variable "update_track" {
  type        = string
  description = "The update track for maintenance (canary or stable)."
  default     = "stable"
  validation {
    condition     = contains(["canary", "stable"], var.update_track)
    error_message = "The update_track must be either canary or stable."
  }
}

variable "enable_public_ip" {
  type        = bool
  description = "Whether to enable public IP for the Cloud SQL instance."
  default     = false
}

variable "vpc_network_id" {
  type        = string
  description = "The ID of the VPC network for private connectivity."
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, stg, prod)."
  default     = "dev"
}

variable "additional_labels" {
  type        = map(string)
  description = "Additional labels to apply to the Cloud SQL instance."
  default     = {}
}

variable "database_flags" {
  type        = map(string)
  description = "Database flags to set on the Cloud SQL instance."
  default     = {}
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the Cloud SQL instance."
  default     = false
}
