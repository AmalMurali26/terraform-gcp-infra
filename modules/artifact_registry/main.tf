resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker container registry"
  format        = "DOCKER"
  project       = var.project_id
}
