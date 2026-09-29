output "private_ip_address" {
  value = google_sql_database_instance.instance.private_ip_address
}

output "instance_connection_name" {
  value = google_sql_database_instance.instance.connection_name
}
