resource "google_transcoder_job_template" "apex_transcoder_job_template" {
  job_template_id = var.transcode_job_template_name
  location        = var.project_region
  project         = var.project_id

  config {
    pubsub_destination {
      topic = var.pubsub_topic
    }

    dynamic "elementary_streams" {
      for_each = var.video_streams
      content {
        key = "video-${elementary_streams.key}"
        video_stream {
          h264 {
            width_pixels  = elementary_streams.value.width
            height_pixels = elementary_streams.value.height
            bitrate_bps   = elementary_streams.value.bitrate
            frame_rate    = var.frame_rate
            profile       = var.h264_profile
          }
        }
      }
    }

    elementary_streams {
      key = "audio_acc"
      audio_stream {
        codec             = var.audio_config.codec
        bitrate_bps       = var.audio_config.bitrate_bps
        channel_count     = var.audio_config.channel_count
        sample_rate_hertz = var.audio_config.sample_rate_hertz
      }
    }

    dynamic "mux_streams" {
      for_each = var.video_streams
      content {
        key       = "ts-${mux_streams.key}"
        container = "ts"
        elementary_streams = [
          "video-${mux_streams.key}",
          "audio_acc"
        ]
        segment_settings {
          segment_duration = var.segment_duration
        }
      }
    }
  }
}
