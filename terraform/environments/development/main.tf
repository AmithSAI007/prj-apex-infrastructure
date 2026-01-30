module "storage" {
  source     = "../../modules/storage"
  project_id = var.project_id
}

module "pubsub" {
  source     = "../../modules/pubsub"
  project_id = var.project_id
}

module "transcoder" {
  source            = "../../modules/transcoder"
  project_id        = var.project_id
  project_region    = var.project_region
  video_definitions = var.video_definitions
  audio_definition  = var.audio_definition
  pubsub_topic      = module.pubsub.topic_id
}
