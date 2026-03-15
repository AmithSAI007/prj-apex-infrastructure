output "topic_id" {
  description = "The ID of the Pub/Sub topic."
  value       = google_pubsub_topic.apex_pubsub_topic.id
}

output "video_ingestion_topic_id" {
  description = "the id of the pub/sub topic for video ingestion."
  value       = google_pubsub_topic.apex_video_ingestion_pubsub_topic.id
}

output "video_ingestion_dead_letter_topic_id" {
  description = "the id of the pub/sub topic for video ingestion dead letter topic."
  value       = google_pubsub_topic.apex_video_ingestion_dead_letter_topic.id
}

output "video_ingestion_dead_letter_subscription_id" {
  description = "the id of the pub/sub subscription for video ingestion."
  value       = google_pubsub_subscription.apex_video_ingestion_dead_letter_subscription.id
}
