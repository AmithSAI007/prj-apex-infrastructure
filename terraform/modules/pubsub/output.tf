output "topic_id" {
  description = "The ID of the Pub/Sub topic."
  value       = google_pubsub_topic.apex_pubsub_topic.id
}
