resource "google_storage_bucket" "apex_dev_gcs_raw_videos" {
  name                        = var.raw_videos_bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  project                     = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "apex_dev_gcs_processed_videos" {
  name                        = var.processed_videos_bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  project                     = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "apex-dev-gcs-video-metadata" {
  name                        = var.video_metadata_bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  project                     = var.project_id
  uniform_bucket_level_access = true
}

data "google_storage_project_service_account" "gcs_account" {
}

resource "google_pubsub_topic_iam_binding" "binding" {
  topic   = google_pubsub_topic.topic.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

resource "google_storage_notification" "apex_video_ingestion_notification" {
  bucket         = google_storage_bucket.apex_dev_gcs_raw_videos.name
  topic          = var.apex_video_ingestion_pubsub_topic_name
  event_types    = ["OBJECT_FINALIZE"]
  payload_format = "JSON_API_V1"
  depends_on = [
    google_pubsub_topic_iam_binding.binding
  ]
}
