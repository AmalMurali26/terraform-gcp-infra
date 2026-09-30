variable "project_id" {
  type = string
}

variable "github_actions_sa_id" {
  type        = string
  description = "Service account ID for Terraform CI/CD automation"
  default     = "github-terraform-ci-sa"
}

variable "gke_sa_id" {
  type        = string
  description = "Unified service account ID for GKE nodes, cluster workloads, and app deployments"
  default     = "gke-app-sa"
}

variable "terraform_wif_pool_id" {
  type        = string
  description = "Workload Identity Pool ID for Terraform CI/CD"
  default     = "github-tf-pool"
}

variable "app_wif_pool_id" {
  type        = string
  description = "Workload Identity Pool ID for Application CI/CD"
  default     = "github-app-pool"
}

variable "wif_provider_id" {
  type        = string
  description = "Provider ID used across the GitHub OIDC pools"
  default     = "github-provider"
}

variable "github_repo_terraform" {
  type        = string
  description = "GitHub repository (owner/repo) executing Terraform"
}

variable "github_repo_app" {
  type        = string
  description = "GitHub repository (owner/repo) executing Application CI/CD"
}

variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace for the workload"
  default     = "default"
}

variable "k8s_service_account_name" {
  type        = string
  description = "Kubernetes ServiceAccount name inside the cluster"
  default     = "app-sa"
}
