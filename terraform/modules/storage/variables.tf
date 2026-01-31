variable "project_id" {
  type        = string
  description = "The unique identifier for the GCP project for resource organization and billing."
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "raw_videos_bucket_name" {
  type        = string
  description = "The name of the GCS bucket for raw videos."
  default     = "apex-dev-gcs-raw-videos"
}

variable "processed_videos_bucket_name" {
  type        = string
  description = "The name of the GCS bucket for processed videos."
  default     = "apex-dev-gcs-processed-videos"
}

variable "bucket_location" {
  type        = string
  description = "The location where the GCS bucket will be created."
  default     = "asia-south1"
}
