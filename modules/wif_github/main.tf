# ==============================================================================
# SA 1 & POOL 1: TERRAFORM INFRASTRUCTURE PIPELINE (PROTECTED)
# ==============================================================================

resource "google_service_account" "github_sa" {
  account_id   = var.github_actions_sa_id
  display_name = "GitHub Actions Terraform CI/CD SA"
  project      = var.project_id

  lifecycle {
    prevent_destroy = true
  }
}

# Terraform IAM roles needed to manage GCP resources
resource "google_project_iam_member" "terraform_roles" {
  for_each = toset([
    "roles/compute.admin",
    "roles/container.admin",
    "roles/cloudsql.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/secretmanager.admin",
    "roles/artifactregistry.admin",
    "roles/servicenetworking.networksAdmin",
    "roles/iam.workloadIdentityPoolAdmin"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_sa.email}"
}

# Workload Identity Pool 1: Terraform
resource "google_iam_workload_identity_pool" "terraform_pool" {
  workload_identity_pool_id = var.terraform_wif_pool_id
  display_name              = "GitHub Actions Terraform Pool"
  project                   = var.project_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_iam_workload_identity_pool_provider" "terraform_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.terraform_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.wif_provider_id
  display_name                       = "GitHub OIDC Terraform Provider"
  project                            = var.project_id

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "assertion.repository == '${var.github_repo_terraform}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Allow Terraform repo runner to impersonate github_sa
resource "google_service_account_iam_member" "terraform_wif_binding" {
  service_account_id = google_service_account.github_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.terraform_pool.name}/attribute.repository/${var.github_repo_terraform}"
}

# ==============================================================================
# SA 2 & POOL 2: GKE NODES, APPLICATION WORKLOADS & APP CI/CD (DESTROYABLE)
# ==============================================================================

resource "google_service_account" "gke_node_sa" {
  account_id   = var.gke_sa_id
  display_name = "GKE Node, App Workload & Deployer SA"
  project      = var.project_id
}

# Combined IAM roles for node execution, app workloads, and CI/CD pushes
resource "google_project_iam_member" "gke_roles" {
  for_each = toset([
    # Standard GKE logging & monitoring
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    # Artifact Registry: pull images on nodes, push from app runners
    "roles/artifactregistry.writer",
    # Secret Manager: read secrets from within pods and deployment tasks
    "roles/secretmanager.secretAccessor",
    # Cloud SQL: reach Postgres database instance
    "roles/cloudsql.client",
    # Deployer: deploy manifests and helm charts to GKE
    "roles/container.developer"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

# Workload Identity Pool 2: Application
resource "google_iam_workload_identity_pool" "app_pool" {
  workload_identity_pool_id = var.app_wif_pool_id
  display_name              = "GitHub Actions Application Pool"
  project                   = var.project_id
}

resource "google_iam_workload_identity_pool_provider" "app_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.app_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.wif_provider_id
  display_name                       = "GitHub OIDC App Provider"
  project                            = var.project_id

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "assertion.repository == '${var.github_repo_app}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# Impersonation 1: Allow App GitHub Actions workflow to impersonate gke_node_sa
resource "google_service_account_iam_member" "app_github_wif_binding" {
  service_account_id = google_service_account.gke_node_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.app_pool.name}/attribute.repository/${var.github_repo_app}"
}

# Impersonation 2: Allow in-cluster KSA to impersonate gke_node_sa (GKE Workload Identity)
resource "google_service_account_iam_member" "gke_ksa_wif_binding" {
  service_account_id = google_service_account.gke_node_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.k8s_namespace}/${var.k8s_service_account_name}]"
}
