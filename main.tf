module "vpc" {
  source = "./modules/vpc"

  project_id         = var.project_id
  region             = var.region
  vpc_name           = var.vpc_name
  subnet_name        = var.subnet_name
  subnet_cidr        = var.subnet_cidr
  pods_cidr_name     = var.pods_cidr_name
  pods_cidr          = var.pods_cidr
  services_cidr_name = var.services_cidr_name
  services_cidr      = var.services_cidr
}

module "wif_github" {
  source = "./modules/wif_github"

  project_id           = var.project_id
  gke_sa_id            = var.gke_sa_id
  github_actions_sa_id = var.github_actions_sa_id
  wif_pool_id          = var.wif_pool_id
  wif_provider_id      = var.wif_provider_id
  github_repo          = var.github_repo
}

module "gke" {
  source = "./modules/gke"

  project_id             = var.project_id
  region                 = var.region
  cluster_name           = var.cluster_name
  node_locations         = var.gke_zones
  network                = module.vpc.network_name
  subnetwork             = module.vpc.subnet_name
  pods_cidr_name         = var.pods_cidr_name
  services_cidr_name     = var.services_cidr_name
  master_ipv4_cidr_block = var.master_ipv4_cidr_block
  node_service_account   = module.wif_github.gke_node_sa_email
  machine_type           = var.gke_machine_type
  disk_size_gb           = var.node_disk_size_gb
  min_node_count         = var.min_node_count
  max_node_count         = var.max_node_count

  depends_on = [module.wif_github]
}

# Auto-generate database password (no secrets checked into git)
resource "random_password" "db_password" {
  length  = 24
  special = false
}

module "cloudsql" {
  source = "./modules/cloudsql"

  project_id       = var.project_id
  region           = var.region
  instance_name             = var.db_instance_name
  database_version          = var.database_version
  tier                      = var.db_tier
  disk_size_gb              = var.db_disk_size_gb
  db_name          = var.db_name
  db_user          = var.db_user
  db_password              = random_password.db_password.result
  network_id       = module.vpc.network_id
  private_vpc_connect_peer = module.vpc.private_vpc_connection

  # Forces Terraform to wait until private IP allocation & peering are fully active
  depends_on = [
    module.vpc.private_vpc_connection
  ]
}

# Dynamically construct secrets from generated values
locals {
  app_secrets = merge(var.additional_secrets, {
    "DB_PASSWORD"  = random_password.db_password.result
    "DATABASE_URL" = "postgresql://${var.db_user}:${random_password.db_password.result}@${module.cloudsql.private_ip_address}:5432/${var.db_name}"
  })
}

module "secrets" {
  source = "./modules/secrets"

  project_id = var.project_id
  secrets    = local.app_secrets
}

module "artifact_registry" {
  source = "./modules/artifact_registry"

  project_id     = var.project_id
  region         = var.region
  repository_ids = var.artifact_repo_ids
}
