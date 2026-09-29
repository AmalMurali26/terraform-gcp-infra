output "gke_node_sa_email" {
  value = google_service_account.gke_node_sa.email
}

output "github_sa_email" {
  value = google_service_account.github_sa.email
}

output "wif_provider_name" {
  value = google_iam_workload_identity_pool_provider.provider.name
}
