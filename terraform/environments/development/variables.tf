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
  description = "The GCP region where the resources will be deployed, impacting latency and compliance."
  validation {
    condition     = length(var.project_region) > 0
    error_message = "The project_region must be specified."
  }
}

variable "message_retention_duration" {
  description = "The duration for which messages are retained in the Pub/Sub topic (in seconds)."
  type        = string
  default     = "604800s" # 7 days
}

variable "ack_deadline_seconds" {
  description = "The acknowledgment deadline for Pub/Sub messages in seconds."
  type        = number
  default     = 60
}

variable "max_delivery_attempts" {
  description = "The maximum number of delivery attempts for a Pub/Sub message before it is sent to the dead letter topic."
  type        = number
  default     = 5
}

# Cloud SQL PostgreSQL Variables
variable "cloudsql_instance_name" {
  description = "The name of the Cloud SQL PostgreSQL instance."
  type        = string
  default     = "apex-dev-cloudsql-postgres"
}

variable "cloudsql_database_name" {
  description = "The name of the default database to create."
  type        = string
  default     = "apex_db"
}
