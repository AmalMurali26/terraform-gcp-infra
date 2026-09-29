# backend.tf
terraform {
  backend "gcs" {
    bucket = "project-2f0ca310-6577-4bf2-93e-tfstate"
    prefix = "terraform/state"
  }
}
