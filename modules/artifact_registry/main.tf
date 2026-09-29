resource "google_artifact_registry_repository" "repos" {
  for_each      = toset(var.repository_ids)
  location      = var.region
  repository_id = each.key
  description   = "Docker repository for ${each.key}"
  format        = "DOCKER"
  project       = var.project_id
}
