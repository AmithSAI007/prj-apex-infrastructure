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
  source                        = "../../modules/iam"
  pubsub_topic                  = module.pubsub.topic_id
  dead_letter_topic_name        = module.pubsub.video_ingestion_dead_letter_topic_id
  dead_letter_subscription_name = module.pubsub.video_ingestion_subscription_id
}

module "transcoder" {
  source         = "../../modules/transcoder"
  project_id     = var.project_id
  project_region = var.project_region
  pubsub_topic   = module.pubsub.topic_id
}

module "registry" {
  source         = "../../modules/registry"
  project_id     = var.project_id
  project_region = var.project_region
}

# module "firestore" {
#   source         = "../../modules/firestore"
#   project_id     = var.project_id
#   project_region = var.project_region
# }

module "cloudsql" {
  source         = "../../modules/cloudsql"
  project_id     = var.project_id
  project_region = var.project_region
  instance_name  = var.cloudsql_instance_name
  database_name  = var.cloudsql_database_name
}
