data "google_project" "project" {}

resource "google_pubsub_topic_iam_member" "transcoder_publisher" {
  topic  = var.pubsub_topic
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-transcoder.iam.gserviceaccount.com"
}

resource "google_pubsub_topic_iam_member" "apex_video_ingestion_pubsub_topic_iam_member" {
  topic  = var.dead_letter_topic_name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_pubsub_subscription_iam_member" "apex_video_ingestion_subscription_iam_member" {
  subscription = var.dead_letter_subscription_name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
