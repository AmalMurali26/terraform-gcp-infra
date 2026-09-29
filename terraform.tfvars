project_id = "project-2f0ca310-6577-4bf2-93e"
region     = "asia-south1"

# VPC
vpc_name           = "prod-vpc"
subnet_name        = "prod-gke-subnet"
subnet_cidr        = "10.0.0.0/20"
pods_cidr_name     = "gke-pods"
pods_cidr          = "10.4.0.0/14"
services_cidr_name = "gke-services"
services_cidr      = "10.8.0.0/20"

# GKE Regional with 2 zones (asia-south1-a, asia-south1-b)
cluster_name           = "prod-private-cluster"
gke_zones              = ["asia-south1-a", "asia-south1-b"]
master_ipv4_cidr_block = "172.16.0.0/28"
gke_machine_type       = "e2-standard-4"
node_disk_size_gb      = 20
min_node_count         = 1
max_node_count         = 3

# Cloud SQL
db_instance_name = "prod-pg-instance"
database_version = "POSTGRES_15"
db_tier          = "db-custom-2-7680"
db_disk_size_gb  = 20
db_name          = "app_db"
db_user          = "app_user"

# Artifact Registry
artifact_repo_id = "prod-container-repo"

# IAM & WIF
gke_sa_id            = "prod-gke-nodes-sa"
github_actions_sa_id = "prod-github-deployer-sa"
wif_pool_id          = "github-actions-pool"
wif_provider_id      = "github-provider"
github_repo          = "my-org/my-app-repo"

