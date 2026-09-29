variable "project_id" { type = string }
variable "region" { type = string }
variable "repository_ids" {
  type        = list(string)
  description = "List of repository IDs to create"
}
