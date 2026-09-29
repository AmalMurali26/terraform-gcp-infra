output "repository_urls" {
  description = "Map of repository names to their image registry endpoints"
  value = {
    for k, v in google_artifact_registry_repository.repos :
    k => "${var.region}-docker.pkg.dev/${var.project_id}/${v.repository_id}"
  }
}
