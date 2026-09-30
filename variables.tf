variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "Primary GCP Region"
  type        = string
}

# VPC & Networking Variables
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the primary subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "Primary CIDR block for nodes/hosts"
  type        = string
}

variable "pods_cidr_name" {
  description = "Secondary range name for GKE Pods"
  type        = string
}

variable "pods_cidr" {
  description = "Secondary CIDR block for GKE Pods"
  type        = string
}

variable "services_cidr_name" {
  description = "Secondary range name for GKE Services"
  type        = string
}

variable "services_cidr" {
  description = "Secondary CIDR block for GKE Services"
  type        = string
}

# GKE Variables
variable "cluster_name" {
  description = "Name of the private GKE cluster"
  type        = string
}

variable "gke_zones" {
  description = "Specific zones within the region to run worker nodes"
  type        = list(string)
}

variable "master_ipv4_cidr_block" {
  description = "CIDR range for GKE master control plane (/28)"
  type        = string
}

variable "gke_machine_type" {
  description = "Compute Engine instance type for GKE nodes"
  type        = string
}

variable "node_disk_size_gb" {
  description = "Storage per node in GB"
  type        = number
  default     = 20
}

variable "min_node_count" {
  description = "Minimum nodes per zone for autoscaler"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum nodes per zone for autoscaler"
  type        = number
  default     = 3
}

# Cloud SQL Variables
variable "db_instance_name" {
  description = "Instance name for Cloud SQL PostgreSQL"
  type        = string
}

variable "database_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "db_tier" {
  description = "Compute tier for Cloud SQL"
  type        = string
}

variable "db_disk_size_gb" {
  description = "Storage disk size in GB for database"
  type        = number
}

variable "db_name" {
  description = "Initial application database name"
  type        = string
}

variable "db_user" {
  description = "Initial application database user"
  type        = string
}

# Artifact Registry Variables
variable "artifact_repo_ids" {
  description = "List of Artifact Registry repository names"
  type        = list(string)
}

# IAM & Workload Identity Federation Variables (2 SAs & 2 Pools)
variable "gke_sa_id" {
  description = "Unified service account ID for GKE worker nodes, in-cluster pods, and app deployer"
  type        = string
  default     = "gke-app-sa"
}

variable "github_actions_sa_id" {
  description = "Service account ID assumed by GitHub Actions for Terraform"
  type        = string
  default     = "github-terraform-ci-sa"
}

variable "terraform_wif_pool_id" {
  description = "Workload Identity Pool ID for Terraform CI/CD"
  type        = string
  default     = "github-tf-pool"
}

variable "app_wif_pool_id" {
  description = "Workload Identity Pool ID for Application CI/CD"
  type        = string
  default     = "github-app-pool"
}

variable "wif_provider_id" {
  description = "Workload Identity Provider ID"
  type        = string
  default     = "github-provider"
}

variable "github_repo_terraform" {
  description = "GitHub repository (owner/repo) executing Terraform IaC"
  type        = string
}

variable "github_repo_app" {
  description = "GitHub repository (owner/repo) executing Application CI/CD"
  type        = string
}

variable "k8s_namespace" {
  description = "Kubernetes namespace for the workload"
  type        = string
  default     = "default"
}

variable "k8s_service_account_name" {
  description = "Kubernetes ServiceAccount name inside the cluster"
  type        = string
  default     = "app-sa"
}

# Secret Manager Extra Variables
variable "additional_secrets" {
  description = "Additional key-value secrets to store (do not add credentials here)"
  type        = map(string)
  default     = {}
}
