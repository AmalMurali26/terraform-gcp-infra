resource "google_secret_manager_secret" "secret" {
  for_each  = toset(nonsensitive(keys(var.secrets)))
  secret_id = each.key
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  for_each    = toset(nonsensitive(keys(var.secrets)))
  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = var.secrets[each.key]
}
