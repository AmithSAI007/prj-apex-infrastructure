resource "google_transcoder_job_template" "apex_transcoder_job_template" {
  job_template_id = var.transcode_job_template_name
  location        = var.project_region
  project         = var.project_id

  config {
    pubsub_destination {
      topic = var.pubsub_topic
    }
    dynamic "elementary_streams" {
      for_each = var.video_definitions
      content {
        key = "video-${elementary_streams.key}"
        video_stream {
          h264 {
            height_pixels = elementary_streams.value.height_pixels
            width_pixels  = elementary_streams.value.width_pixels
            bitrate_bps   = elementary_streams.value.bitrate_bps
            frame_rate    = elementary_streams.value.frame_rate
          }
        }
      }
    }

    elementary_streams {
      key = "audio-stream0"
      audio_stream {
        codec       = var.audio_definition.codec
        bitrate_bps = var.audio_definition.bitrate_bps
      }
    }

    dynamic "mux_streams" {
      for_each = var.video_definitions
      content {
        key                = mux_streams.key
        container          = "mp4"
        elementary_streams = ["video-${mux_streams.key}", "audio-stream0"]
      }
    }
  }
}
