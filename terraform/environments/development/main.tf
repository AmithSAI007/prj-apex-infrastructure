module "pubsub" {
  source                     = "../../modules/pubsub"
  project_id                 = var.project_id
  message_retention_duration = var.message_retention_duration
  ack_deadline_seconds       = var.ack_deadline_seconds
  max_delivery_attempts      = var.max_delivery_attempts
}

module "storage" {
  source                                 = "../../modules/storage"
  project_id                             = var.project_id
  apex_video_ingestion_pubsub_topic_name = module.pubsub.video_ingestion_topic_id
}

module "iam" {
  source       = "../../modules/iam"
  pubsub_topic = module.pubsub.topic_id
}

module "transcoder" {
  source            = "../../modules/transcoder"
  project_id        = var.project_id
  project_region    = var.project_region
  video_definitions = var.video_definitions
  audio_definition  = var.audio_definition
  pubsub_topic      = module.pubsub.topic_id
}

module "registry" {
  source         = "../../modules/registry"
  project_id     = var.project_id
  project_region = var.project_region
}

module "firestore" {
  source         = "../../modules/firestore"
  project_id     = var.project_id
  project_region = var.project_region
}
