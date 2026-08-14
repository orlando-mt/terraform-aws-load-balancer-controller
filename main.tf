locals {
  service_account_name = "aws-load-balancer-controller"
  oidc_issuer          = replace(var.oidc_provider_url, "https://", "")
}

resource "helm_release" "this" {
  name       = var.release_name
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.chart_version
  namespace  = var.namespace

  timeout         = var.timeout
  wait            = true
  cleanup_on_fail = true

  # The chart creates the service account with the IRSA annotation, so the
  # kubernetes provider is not required by this module.
  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = local.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.this.arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "replicaCount"
    value = var.replica_count
  }

  dynamic "set" {
    for_each = var.helm_values
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [aws_iam_role_policy_attachment.this]
}
