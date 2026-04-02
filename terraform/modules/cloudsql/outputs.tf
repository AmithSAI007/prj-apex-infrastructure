// Cloud SQL PostgreSQL Outputs

output "instance_id" {
  description = "The ID of the Cloud SQL PostgreSQL instance."
  value       = google_sql_database_instance.apex_postgres_instance.id
}

output "instance_name" {
  description = "The name of the Cloud SQL PostgreSQL instance."
  value       = google_sql_database_instance.apex_postgres_instance.name
}

output "instance_connection_name" {
  description = "The connection name of the Cloud SQL PostgreSQL instance (used by Cloud SQL Proxy)."
  value       = google_sql_database_instance.apex_postgres_instance.connection_name
}

output "instance_ip_address" {
  description = "The public IP address of the Cloud SQL PostgreSQL instance (if enabled)."
  value       = google_sql_database_instance.apex_postgres_instance.public_ip_address
}

output "instance_private_ip_address" {
  description = "The private IP address of the Cloud SQL PostgreSQL instance."
  value       = google_sql_database_instance.apex_postgres_instance.private_ip_address
}

output "database_id" {
  description = "The ID of the created database."
  value       = google_sql_database.apex_database.id
}

output "database_name" {
  description = "The name of the created database."
  value       = google_sql_database.apex_database.name
}

output "postgres_version" {
  description = "The PostgreSQL version of the Cloud SQL instance."
  value       = "POSTGRES_18"
}
