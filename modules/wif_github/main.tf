# Workload Identity Pool 2: Application
resource "google_iam_workload_identity_pool" "app_pool" {
  workload_identity_pool_id = var.app_wif_pool_id
  display_name              = "GitHub Actions Application Pool"
  project                   = var.project_id

  lifecycle {
    prevent_destroy = true
  }
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

  lifecycle {
    prevent_destroy = true
  }
}
