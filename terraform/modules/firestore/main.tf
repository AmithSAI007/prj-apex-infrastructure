resource "google_firestore_database" "apex_firestore_db" {
  project                           = var.project_id
  name                              = var.database_name
  location_id                       = var.project_region
  type                              = var.database_type
  database_edition                  = var.database_edition
  delete_protection_state           = var.delete_protection_state
  concurrency_mode                  = var.concurrency_mode
  point_in_time_recovery_enablement = var.point_in_time_recovery_enablement
  deletion_policy                   = var.deletion_policy
}
