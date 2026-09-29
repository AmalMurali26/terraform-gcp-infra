output "vpc_id" {
  value = module.vpc.network_id
}

output "gke_cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "cloudsql_private_ip" {
  value = module.cloudsql.private_ip_address
}

output "wif_provider_resource_name" {
  value = module.wif_github.wif_provider_name
}

output "github_service_account" {
  value = module.wif_github.github_sa_email
}

output "artifact_registry_repo" {
  value = module.artifact_registry.repository_url
}
