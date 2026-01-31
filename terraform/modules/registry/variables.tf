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

variable "repository_name" {
  type        = string
  description = "The name of the Artifact Registry repository."
  validation {
    condition     = length(var.repository_name) > 0
    error_message = "The repository_name must not be empty."
  }
  default = "prj-apex-artifact-registry"
}

variable "artifact_format" {
  type        = string
  description = "The format of artifacts stored in the registry (e.g., DOCKER, MAVEN, NPM)."
  default     = "DOCKER"
  validation {
    condition     = contains(["DOCKER", "MAVEN", "NPM"], var.artifact_format)
    error_message = "Valid values for artifact_format are: DOCKER, MAVEN, NPM."
  }
}

variable "delete_untagged_images" {
  type        = string
  description = "Identifier for the cleanup policy that deletes untagged images."
  default     = "delete_untagged_images"
}

variable "delete_action" {
  type        = string
  description = "The action to perform in the cleanup policy (e.g., DELETE, KEEP)."
  default     = "DELETE"
}

variable "untagged_tag_state" {
  type        = string
  description = "The tag state condition for the cleanup policy (e.g., TAGGED, UNTAGGED)."
  default     = "UNTAGGED"
}

variable "image_count" {
  type        = number
  description = "The number of most recent untagged images to retain."
  default     = 10
}


variable "retain_tagged_images_policy_id" {
  type        = string
  description = "Identifier for the cleanup policy that retains tagged images."
  default     = "retain-tagged-prod-dev"
}

variable "retain_action" {
  type        = string
  description = "The action to perform for retaining tagged images (e.g., KEEP)."
  default     = "KEEP"
}

variable "tagged_tag_state" {
  type        = string
  description = "The tag state condition for retaining tagged images."
  default     = "TAGGED"
}

variable "tag_prefixes_to_keep" {
  type        = list(string)
  description = "List of tag prefixes for images that should be retained."
  default     = ["production", "development"]
}
