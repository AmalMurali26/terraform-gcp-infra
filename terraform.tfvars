project_id = "project-2f0ca310-6577-4bf2-93e"
region     = "asia-south1"

# VPC
vpc_name           = "terraform-vpc4gke"
subnet_name        = "gke-subnet"
subnet_cidr        = "10.0.0.0/20"
pods_cidr_name     = "gke-pods"
pods_cidr          = "10.4.0.0/14"
services_cidr_name = "gke-services"
services_cidr      = "10.8.0.0/20"

# GKE Regional with 2 zones (asia-south1-a, asia-south1-b)
cluster_name           = "gke-private-cluster"
gke_zones              = ["asia-south1-a", "asia-south1-b"]
master_ipv4_cidr_block = "172.16.0.0/28"
gke_machine_type       = "e2-standard-4"
node_disk_size_gb      = 20
min_node_count         = 1
max_node_count         = 3

# Cloud SQL
db_instance_name = "gke-pg-instance"
database_version = "POSTGRES_15"
db_tier          = "db-custom-2-7680"
db_disk_size_gb  = 20
db_name          = "app_db"
db_user          = "app_user"

# Artifact Registry
artifact_repo_ids = [
  "frontend-repo",
  "backend-repo"
]

# IAM & WIF (2 SAs & 2 Pools)
gke_sa_id             = "gke-app-sa"
github_actions_sa_id  = "github-terraform-ci-sa"
terraform_wif_pool_id = "github-tf-pool"
app_wif_pool_id       = "github-app-pool"
wif_provider_id       = "github-provider"

# Set your actual GitHub repository names here
github_repo_terraform = "my-org/my-terraform-repo"
github_repo_app       = "my-org/my-app-repo"

k8s_namespace            = "default"
k8s_service_account_name = "app-sa"
