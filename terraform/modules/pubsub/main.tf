// Pubsub topic and subcription for ingestion service
resource "google_pubsub_topic" "apex_video_ingestion_pubsub_topic" {
  project                    = var.project_id
  name                       = var.pubsub_video_ingestion_topic_name
  message_retention_duration = var.message_retention_duration
}

resource "google_pubsub_topic" "apex_video_ingestion_dead_letter_topic" {
  project                    = var.project_id
  name                       = var.pubsub_video_ingestion_dead_letter_topic_name
  message_retention_duration = var.message_retention_duration
}

resource "google_pubsub_subscription" "apex_video_ingestion_subscription" {
  name  = var.apex_video_ingestion_subscription_name
  topic = google_pubsub_topic.apex_video_ingestion_pubsub_topic.id

  ack_deadline_seconds = 180

  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.apex_video_ingestion_dead_letter_topic.id
    max_delivery_attempts = 5
  }
}

resource "google_pubsub_subscription" "apex_video_ingestion_dead_letter_subscription" {
  name    = var.apex_video_ingestion_dead_letter_subscription_name
  topic   = google_pubsub_topic.apex_video_ingestion_dead_letter_topic.id
  project = var.project_id

  expiration_policy {
    ttl = ""
  }

  message_retention_duration = var.message_retention_duration
}

// Pub/Sub topic for Transcoder API job completion notifications
resource "google_pubsub_topic" "apex_pubsub_topic" {
  project = var.project_id
  name    = var.apex_transcoder_api_job_completed_topic_name
}

resource "google_pubsub_topic" "apex_pubsub_topic_for_transcoder_dead_letter" {
  project                    = var.project_id
  name                       = var.apex_transcoder_api_job_completed_dead_letter_topic_name
  message_retention_duration = var.message_retention_duration
}

resource "google_pubsub_subscription" "apex_callback_subscription" {
  name                 = var.apex_callback_subscription_name
  topic                = google_pubsub_topic.apex_pubsub_topic.id
  ack_deadline_seconds = 180

}

// Pub/Sub schema for video pipeline events
resource "google_pubsub_schema" "apex_video_pipeline_event_schema" {
  project = var.project_id
  name    = var.apex_video_pipeline_event_schema_name

  type       = "AVRO"
  definition = file("${path.module}/schemas/video_pipeline_event_schema.avsc")
}

resource "google_pubsub_topic" "apex_pubsub_topic_for_video_pipeline_events" {
  project = var.project_id
  name    = var.apex_video_processing_topic_name

  schema_settings {
    schema   = google_pubsub_schema.apex_video_pipeline_event_schema.id
    encoding = "JSON"
  }
}

resource "google_pubsub_subscription" "apex_video_pipeline_event_subscription" {
  name                 = var.apex_thumbnail_generation_subscription_name
  topic                = google_pubsub_topic.apex_pubsub_topic_for_video_pipeline_events.id
  ack_deadline_seconds = 180
}
