resource "google_artifact_registry_repository" "artifact_registry" {
  location      = var.project_region
  repository_id = var.repository_name
  description   = "Artifact registry name"
  format        = var.artifact_format

  cleanup_policies {
    id     = var.retain_tagged_images_policy_id
    action = var.retain_action
    condition {
      tag_state    = var.tagged_tag_state
      tag_prefixes = var.tag_prefixes_to_keep
    }
  }

  cleanup_policies {
    id     = var.delete_untagged_images
    action = var.retain_action
    most_recent_versions {
      keep_count = var.image_count
    }
  }

}
