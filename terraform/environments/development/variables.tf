variable "PROJECT_ID" {
  type        = string
  description = "The unique identifier for the GCP project for resource organization and billing."
  validation {
    condition     = length(var.PROJECT_ID) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "PROJECT_REGION" {
  type        = string
  description = "The GCP region where the resources will be deployed, impacting latency and compliance."
  validation {
    condition     = length(var.PROJECT_REGION) > 0
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
