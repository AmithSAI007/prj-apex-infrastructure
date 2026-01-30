variable "PROJECT_ID" {
  type        = string
  description = "The unique identifier for the GCP project for resource organization and billing."
  validation {
    condition     = length(var.PROJECT_ID) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "PROJECT_REGION" {
  type        = string
  description = "The GCP region where the resources will be deployed, impacting latency and compliance."
  validation {
    condition     = length(var.PROJECT_REGION) > 0
    error_message = "The project_region must be specified.."
  }
}
