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

variable "transcode_job_template_name" {
  description = "The name of the Transcoder job template."
  type        = string
  default     = "apex-transcoder-job-template"
}

variable "video_streams" {
  description = "A map defining the video elementary streams for different qualities (e.g., sd, hd)."
  type = map(object({
    width   = number
    height  = number
    bitrate = number
  }))
  default = {
    "360p" = {
      width   = 640
      height  = 360
      bitrate = 600000
    },
    "480p" = {
      width   = 854
      height  = 480
      bitrate = 1000000
    },
    "720p" = {
      width   = 1280
      height  = 720
      bitrate = 2500000
    },
    "1080p" = {
      width   = 1920
      height  = 1080
      bitrate = 5000000
    }
  }

  validation {
    condition     = length(var.video_streams) > 0
    error_message = "At least one video stream definition must be provided."
  }

  validation {
    condition     = alltrue([for stream in values(var.video_streams) : stream.width > 0 && stream.height > 0 && stream.bitrate > 0])
    error_message = "All video stream definitions must have positive width, height, and bitrate."
  }

  validation {
    condition     = alltrue([for k, v in var.video_streams : v.bitrate > 0 && v.bitrate <= 50000000])
    error_message = "All video stream bitrates must be between 1 and 50,000,000 bps."
  }
}

variable "frame_rate" {
  description = "Video frame rate in frames per second (fps)."
  type        = number
  default     = 30

  validation {
    condition     = contains([24, 25, 30, 60], var.frame_rate)
    error_message = "Frame rate must be one of the following: 24, 25, 30, or 60 fps."
  }
}

variable "h264_profile" {
  description = "The H.264 profile to use for video encoding."
  type        = string
  default     = "high"

  validation {
    condition     = contains(["baseline", "main", "high"], var.h264_profile)
    error_message = "H.264 profile must be one of the following: 'baseline', 'main', or 'high'."
  }
}

variable "audio_config" {
  description = "Audio stream configuration"
  type = map(object({
    codec             = string
    bitrate_bps       = number
    sample_rate_hertz = number
    channel_count     = number
  }))
  default = {
    "audio_acc" = {
      codec             = "aac"
      bitrate_bps       = 128000
      sample_rate_hertz = 48000
      channel_count     = 2
    }
  }

  validation {
    condition     = contains(["aac", "mp3"], var.audio_config.codec)
    error_message = "Audio codec must be either 'aac' or 'mp3'."
  }

  validation {
    condition     = var.audio_config.bitrate_bps >= 64000 && var.audio_config.bitrate_bps <= 320000
    error_message = "Audio bitrate must be between 64,000 and 320,000 bps."
  }

  validation {
    condition     = contains([44100, 48000], var.audio_config.sample_rate_hertz)
    error_message = "Audio sample rate must be either 44100 or 48000 Hz."
  }

  validation {
    condition     = "contains([1, 2], var.audio_config.channel_count)"
    error_message = "Audio channel count must be either 1 (mono) or 2 (stereo)."
  }
}

variable "standalone_audio_filename" {
  description = "The filename for the standalone audio output (without extension)."
  type        = string
  default     = "audio.m4a"
}

variable "segment_duration" {
  description = "The duration of each video segment in seconds for HLS output."
  type        = string
  default     = "6s"

  validation {
    condition     = can(regex("^\\d+(\\.\\d+)?s$", var.segment_duration))
    error_message = "Segment duration must be a string in the format of a number followed by 's' (e.g., '6s')."
  }
}

variable "manifest_filename" {
  description = "The filename for the HLS manifest output (without extension)."
  type        = string
  default     = "manifest.m3u8"
}

variable "pubsub_topic" {
  description = "The Pub/Sub topic to which the Transcoder job will publish notifications."
  type        = string
}
