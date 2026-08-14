variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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
