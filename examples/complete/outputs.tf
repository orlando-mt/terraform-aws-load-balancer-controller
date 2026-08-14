output "iam_role_arn" {
  description = "IRSA role used by the controller"
  value       = module.load_balancer_controller.iam_role_arn
}

output "release_status" {
  description = "Status of the Helm release"
  value       = module.load_balancer_controller.release_status
}
