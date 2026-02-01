variable "project_id" {
  type        = string
  description = "The unique identifier for the GCP project for resource organization and billing."
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "pubsub_schema_name" {
  description = "The name of the Pub/Sub schema."
  type        = string
  default     = "apex-transcoder-schema"
}

variable "pubsub_topic_name" {
  description = "The name of the Pub/Sub topic."
  type        = string
  default     = "apex-transcoder-status-topic"
}
