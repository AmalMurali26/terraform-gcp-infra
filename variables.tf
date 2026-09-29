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
variable "artifact_repo_id" {
  description = "Repository name for Artifact Registry"
  type        = string
}

# IAM & Workload Identity Federation Variables
variable "gke_sa_id" {
  description = "Service account ID for GKE worker nodes"
  type        = string
}

variable "github_actions_sa_id" {
  description = "Service account ID assumed by GitHub Actions"
  type        = string
}

variable "wif_pool_id" {
  description = "Workload Identity Pool ID"
  type        = string
}

variable "wif_provider_id" {
  description = "Workload Identity Provider ID"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository formatted as owner/repo"
  type        = string
}

# Secret Manager Extra Variables (Optional non-generated secrets)
variable "additional_secrets" {
  description = "Additional key-value secrets to store (do not add credentials here)"
  type        = map(string)
  default     = {}
}
