resource "google_pubsub_schema" "apex_pubsub_schema" {
  project = var.project_id
  name    = var.pubsub_schema_name

  type       = "AVRO"
  definition = file("${path.module}/schemas/apex_schema.avsc")
}

resource "google_pubsub_topic" "apex_pubsub_topic" {
  project = var.project_id
  name    = var.pubsub_topic_name

  # schema_settings {
  #   schema   = google_pubsub_schema.apex_pubsub_schema.id
  #   encoding = "JSON"
  # }
}

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
  name    = var.apex_video_ingestion_subscription_name
  topic   = google_pubsub_topic.apex_video_ingestion_dead_letter_topic.id
  project = var.project_id

  expiration_policy {
    ttl = ""
  }

  message_retention_duration = var.message_retention_duration
}
