terraform {
  backend "gcs" {
    bucket = "prj-apex-infra-terraform-state"
    prefix = "terraform/state"
  }
}
