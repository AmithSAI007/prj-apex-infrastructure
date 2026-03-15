data "google_project" "project" {}

resource "google_pubsub_topic_iam_member" "transcoder_publisher" {
  topic  = var.pubsub_topic
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-transcoder.iam.gserviceaccount.com"
}


resource "google_pubsub_topic_iam_member" "apex_video_ingestion_pubsub_topic_iam_member" {
  topic  = google_pubsub_topic.apex_video_ingestion_dead_letter_topic.id
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_pubsub_subscription_iam_member" "apex_video_ingestion_subscription_iam_member" {
  subscription = google_pubsub_subscription.apex_video_ingestion_subscription.id
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
