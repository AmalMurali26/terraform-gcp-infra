output "vpc_id" {
  value = module.vpc.network_id
}

output "gke_cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "cloudsql_private_ip" {
  value = module.cloudsql.private_ip_address
}

# Terraform CI/CD Auth Outputs
output "terraform_wif_provider_resource_name" {
  value = module.wif_github.terraform_wif_provider_name
}

output "terraform_service_account" {
  value = module.wif_github.terraform_sa_email
}

# Application CI/CD & Cluster Auth Outputs
output "app_wif_provider_resource_name" {
  value = module.wif_github.app_wif_provider_name
}

output "app_service_account" {
  value = module.wif_github.gke_node_sa_email
}

output "artifact_registry_repos" {
  value = module.artifact_registry.repository_urls
}
