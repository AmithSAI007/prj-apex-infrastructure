data "google_project" "project" {}

resource "google_pubsub_topic_iam_member" "transcoder_publisher" {
  topic  = var.pubsub_topic
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-transcoder.iam.gserviceaccount.com"
}
