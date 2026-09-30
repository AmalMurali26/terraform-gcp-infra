output "terraform_sa_email" {
  value = google_service_account.github_sa.email
}

output "terraform_wif_provider_name" {
  value = google_iam_workload_identity_pool_provider.terraform_provider.name
}

output "gke_node_sa_email" {
  value = google_service_account.gke_node_sa.email
}

output "app_wif_provider_name" {
  value = google_iam_workload_identity_pool_provider.app_provider.name
}
