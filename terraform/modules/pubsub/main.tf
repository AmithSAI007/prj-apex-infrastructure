resource "google_pubsub_schema" "apex_pubsub_schema" {
  project = var.project_id
  name    = var.pubsub_schema_name

  type       = "AVRO"
  definition = file("${path.module}/schemas/apex_schema.avsc")
}

resource "google_pubsub_topic" "apex_pubsub_topic" {
  project = var.project_id
  name    = var.pubsub_topic_name

  schema_settings {
    schema   = google_pubsub_schema.apex_pubsub_schema.id
    encoding = "JSON"
  }
}
