// Cloud SQL PostgreSQL Instance for Project Apex
// PostgreSQL 18 - Latest version as of April 2026

resource "google_sql_database_instance" "apex_postgres_instance" {
  project             = var.project_id
  name                = var.instance_name
  database_version    = "POSTGRES_18"
  region              = var.project_region
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    edition           = var.edition
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_type         = var.disk_type

    backup_configuration {
      enabled                        = true
      start_time                     = var.backup_start_time
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 7
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.update_track
    }

    ip_configuration {
      ipv4_enabled                                  = var.enable_public_ip
      private_network                               = var.vpc_network_id
      enable_private_path_for_google_cloud_services = var.enable_private_path
      ssl_mode                                      = var.ssl_mode
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = 1024
      record_application_tags = true
      record_client_address   = true
    }

    user_labels = merge(
      {
        environment = var.environment
        service     = "cloudsql"
        managed_by  = "terraform"
      },
      var.additional_labels
    )

    // Database flags for production readiness
    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.key
        value = database_flags.value
      }
    }
  }
}

// Default database
resource "google_sql_database" "apex_database" {
  project  = var.project_id
  name     = var.database_name
  instance = google_sql_database_instance.apex_postgres_instance.name
}


