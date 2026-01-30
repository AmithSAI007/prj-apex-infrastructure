resource "google_storage_bucket" "apex_dev_gcs_raw_videos" {
  name                        = var.raw_videos_bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  project                     = var.PROJECT_ID
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "apex_dev_gcs_processed_videos" {
  name                        = var.processed_videos_bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  project                     = var.PROJECT_ID
  uniform_bucket_level_access = true
}
