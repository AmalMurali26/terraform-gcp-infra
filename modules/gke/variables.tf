variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "node_locations" {
  description = "Specific zones for node placement"
  type        = list(string)
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "pods_cidr_name" {
  type = string
}

variable "services_cidr_name" {
  type = string
}

variable "master_ipv4_cidr_block" {
  type = string
}

variable "node_service_account" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "disk_size_gb" {
  type    = number
  default = 20
}

variable "min_node_count" {
  type    = number
  default = 1
}

variable "max_node_count" {
  type    = number
  default = 3
}
