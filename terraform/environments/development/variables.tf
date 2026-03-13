variable "project_id" {
  type        = string
  description = "The unique identifier for the GCP project for resource organization and billing."
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "project_region" {
  type        = string
  description = "The GCP region where the resources will be deployed, impacting latency and compliance."
  validation {
    condition     = length(var.project_region) > 0
    error_message = "The project_region must be specified."
  }
}

variable "video_definitions" {
  description = "A map defining the video elementary streams for different qualities (e.g., sd, hd)."
  type = map(object({
    width_pixels  = number
    height_pixels = number
    bitrate_bps   = number
    frame_rate    = number
  }))
  default = {
    "sd" = {
      width_pixels  = 640
      height_pixels = 360
      bitrate_bps   = 1000000
      frame_rate    = 30
    },
    "hd" = {
      width_pixels  = 1280
      height_pixels = 720
      bitrate_bps   = 2500000
      frame_rate    = 30
    }
  }
}

variable "audio_definition" {
  description = "An object defining the audio elementary stream."
  type = object({
    codec       = string
    bitrate_bps = number
  })
  default = {
    codec       = "aac"
    bitrate_bps = 64000
  }
}

variable "message_retention_duration" {
  description = "The duration for which messages are retained in the Pub/Sub topic (in seconds)."
  type        = string
  default     = "604800s" # 7 days
}

variable "ack_deadline_seconds" {
  description = "The acknowledgment deadline for Pub/Sub messages in seconds."
  type        = number
  default     = 60
}

variable "max_delivery_attempts" {
  description = "The maximum number of delivery attempts for a Pub/Sub message before it is sent to the dead letter topic."
  type        = number
  default     = 5
}
