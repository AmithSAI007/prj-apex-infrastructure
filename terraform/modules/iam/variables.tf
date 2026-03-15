variable "pubsub_topic" {
  description = "The Pub/Sub topic to which the Transcoder job will publish notifications."
  type        = string
}

variable "dead_letter_topic_name" {
  description = "The name of the Pub/Sub topic to be used as a dead letter topic for the video ingestion subscription."
  type        = string
}

variable "dead_letter_subscription_name" {
  description = "The name of the Pub/Sub subscription to be used for the dead letter topic in the video ingestion subscription."
  type        = string
}
