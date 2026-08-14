variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "Name of an existing EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC of the cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the cluster OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC issuer URL of the cluster"
  type        = string
}

variable "chart_version" {
  description = "Chart version to install"
  type        = string
  default     = null
}

variable "replica_count" {
  description = "Controller replicas"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags applied to the IAM resources"
  type        = map(string)
  default     = {}
}
