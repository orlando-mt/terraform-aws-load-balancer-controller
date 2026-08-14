variable "cluster_name" {
  description = "Name of the EKS cluster the controller manages"
  type        = string
}

variable "region" {
  description = "AWS region of the cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID of the cluster"
  type        = string
}

# --- IRSA ------------------------------------------------------------------

variable "oidc_provider_arn" {
  description = "ARN of the cluster's IAM OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC issuer URL of the cluster (with or without the https:// prefix)"
  type        = string
}

variable "role_name" {
  description = "Name of the IRSA role (defaults to <cluster_name>-aws-load-balancer-controller)"
  type        = string
  default     = null
}

variable "policy_name" {
  description = "Name of the IAM policy (defaults to <cluster_name>-aws-load-balancer-controller)"
  type        = string
  default     = null
}

variable "iam_policy_json" {
  description = "Override for the controller IAM policy. Use it to track a newer upstream policy version"
  type        = string
  default     = null
}

# --- Helm release ----------------------------------------------------------

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "chart_version" {
  description = "Version of the aws-load-balancer-controller chart. Pin it for reproducible rollouts"
  type        = string
  default     = null
}

variable "namespace" {
  description = "Namespace where the controller is installed"
  type        = string
  default     = "kube-system"
}

variable "replica_count" {
  description = "Number of controller replicas (2 recommended for HA)"
  type        = number
  default     = 2
}

variable "timeout" {
  description = "Helm release timeout in seconds"
  type        = number
  default     = 600
}

variable "helm_values" {
  description = "Additional Helm values as a flat map of key to value (e.g. { \"nodeSelector.workload\" = \"system\" })"
  type        = map(string)
  default     = {}
}

# --- Tags ------------------------------------------------------------------

variable "tags" {
  description = "Tags to apply to the IAM resources"
  type        = map(string)
  default     = {}
}
