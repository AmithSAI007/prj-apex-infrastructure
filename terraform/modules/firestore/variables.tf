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

variable "database_name" {
  type        = string
  description = "The name of the Firestore database instance."
  default     = "apex-firestore-db"
}

variable "database_type" {
  type        = string
  description = "The type of Firestore database (NATIVE or DATASTORE_MODE)."
  default     = "FIRESTORE_NATIVE"
  validation {
    condition     = var.database_type == "FIRESTORE_NATIVE" || var.database_type == "DATASTORE_MODE"
    error_message = "The database_type must be either 'NATIVE' or 'DATASTORE_MODE'."
  }
}

variable "delete_protection_state" {
  type        = string
  description = "Indicates whether delete protection is enabled for the Firestore database."
  default     = "DELETE_PROTECTION_ENABLED"
}

variable "concurrency_mode" {
  type        = string
  description = "The concurrency mode for the Firestore database (OPTIMISTIC or PESSIMISTIC)."
  default     = "OPTIMISTIC"
  validation {
    condition     = var.concurrency_mode == "OPTIMISTIC" || var.concurrency_mode == "PESSIMISTIC"
    error_message = "The concurrency_mode must be either 'OPTIMISTIC' or 'PESSIMISTIC'."
  }
}

variable "database_edition" {
  type        = string
  description = "The edition of the Firestore database (STANDARD or ENTERPRISE)."
  default     = "STANDARD"
  validation {
    condition     = var.database_edition == "STANDARD" || var.database_edition == "ENTERPRISE"
    error_message = "The database_edition must be either 'STANDARD' or 'ENTERPRISE'."
  }
}

variable "point_in_time_recovery_enablement" {
  type        = string
  description = "Indicates whether point-in-time recovery is enabled for the Firestore database."
  default     = "POINT_IN_TIME_RECOVERY_ENABLED"
  validation {
    condition     = var.point_in_time_recovery_enablement == "POINT_IN_TIME_RECOVERY_ENABLED" || var.point_in_time_recovery_enablement == "POINT_IN_TIME_RECOVERY_DISABLED"
    error_message = "The point_in_time_recovery_enablement must be either 'POINT_IN_TIME_RECOVERY_ENABLED' or 'POINT_IN_TIME_RECOVERY_DISABLED'."
  }
}

variable "deletion_policy" {
  type        = string
  description = "The deletion policy for the Firestore database (RETAIN or DELETE)."
  default     = "DELETE"
  validation {
    condition     = var.deletion_policy == "ABANDON" || var.deletion_policy == "DELETE"
    error_message = "The deletion_policy must be either 'ABANDON' or 'DELETE'."
  }
}
