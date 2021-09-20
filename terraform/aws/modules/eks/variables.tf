variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "cluster_role_arn" {}

variable "cluster_subnet_ids" {}

variable "node_group_subnet_ids" {}

variable "node_role_arn" {}

variable "node_group_keypair_name" {}

variable "instance_types" {}

variable "scaling_config_desired_size" {}

variable "scaling_config_max_size" {}

variable "scaling_config_min_size" {}