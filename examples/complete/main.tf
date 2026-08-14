provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    }
  }
}

module "load_balancer_controller" {
  source = "../../"

  cluster_name = var.cluster_name
  region       = var.region
  vpc_id       = var.vpc_id

  oidc_provider_arn = var.oidc_provider_arn
  oidc_provider_url = var.oidc_provider_url

  # Pin the chart version for reproducible rollouts
  chart_version = "1.13.0"
  replica_count = 2

  tags = {
    Project   = "example"
    ManagedBy = "terraform"
  }
}
