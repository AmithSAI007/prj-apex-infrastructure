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

variable "apex_video_pipeline_event_schema_name" {
  description = "The name of the Pub/Sub schema for video pipeline events."
  type        = string
  default     = "apex-video-pipeline-event-schema"
}

variable "pubsub_video_ingestion_topic_name" {
  description = "The name of the Pub/Sub topic for video ingestion."
  type        = string
  default     = "apex.video-ingestion.gcs.object-finalized"
}

variable "message_retention_duration" {
  description = "The duration for which messages are retained in the Pub/Sub topic (in seconds)."
  type        = string
}

variable "apex_transcoder_api_job_completed_topic_name" {
  description = "The name of the Pub/Sub topic."
  type        = string
  default     = "apex.video-transcoding.transcoder-api.job-completed"
}

variable "apex_transcoder_api_job_completed_dead_letter_topic_name" {
  description = "The name of the Pub/Sub topic."
  type        = string
  default     = "apex.video-transcoding.transcoder-api.job-completed.dlq"
}

variable "apex_video_ingestion_subscription_name" {
  description = "The name of the Pub/Sub subscription for video ingestion."
  type        = string
  default     = "apex.video-ingestion.gcs.object-finalized.ingestion-service"
}

variable "apex_video_ingestion_dead_letter_subscription_name" {
  description = "The name of the Pub/Sub subscription for video ingestion."
  type        = string
  default     = "apex.video-ingestion.gcs.object-finalized.ingestion-service.dlq.subscription"
}

variable "pubsub_video_ingestion_dead_letter_topic_name" {
  description = "The name of the Pub/Sub topic for dead letter messages from video ingestion."
  type        = string
  default     = "apex.video-ingestion.gcs.object-finalized.ingestion-service.dlq"
}

variable "ack_deadline_seconds" {
  description = "The acknowledgment deadline for Pub/Sub messages in seconds."
  type        = number
}

variable "max_delivery_attempts" {
  description = "The maximum number of delivery attempts for a Pub/Sub message before it is sent to the dead letter topic."
  type        = number
}

variable "apex_video_processing_topic_name" {
  description = "The name of the Pub/Sub topic for video processing events."
  type        = string
  default     = "apex.video-processing.pipeline.completed"
}

variable "apex_callback_subscription_name" {
  description = "The name of the Pub/Sub subscription for video processing callbacks."
  type        = string
  default     = "apex.video-processing.transcoder-api.job-completed.callback-service"
}

variable "apex_thumbnail_generation_subscription_name" {
  description = "The name of the Pub/Sub subscription for thumbnail generation callbacks."
  type        = string
  default     = "apex.video-processing.pipeline.completed.thumbnail-generator"
}
