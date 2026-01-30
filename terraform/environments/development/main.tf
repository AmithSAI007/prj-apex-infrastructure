module "storage" {
  source     = "../../modules/storage"
  PROJECT_ID = var.PROJECT_ID
}

module "pubsub" {
  source     = "../../modules/pubsub"
  PROJECT_ID = var.PROJECT_ID
}

module "transcoder" {
  source            = "../../modules/transcoder"
  PROJECT_ID        = var.PROJECT_ID
  PROJECT_REGION    = var.PROJECT_REGION
  video_definitions = var.video_definitions
  audio_definition  = var.audio_definition
  pubsub_topic      = module.pubsub.topic_id
}
