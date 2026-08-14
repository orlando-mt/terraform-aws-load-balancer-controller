output "iam_role_arn" {
  description = "ARN of the IRSA role used by the controller"
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "Name of the IRSA role"
  value       = aws_iam_role.this.name
}

output "iam_policy_arn" {
  description = "ARN of the controller IAM policy"
  value       = aws_iam_policy.this.arn
}

output "service_account_name" {
  description = "Name of the service account created by the chart"
  value       = local.service_account_name
}

output "namespace" {
  description = "Namespace where the controller is installed"
  value       = var.namespace
}

output "release_name" {
  description = "Name of the Helm release"
  value       = helm_release.this.name
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.this.status
}

output "chart_version" {
  description = "Chart version installed"
  value       = helm_release.this.version
}
