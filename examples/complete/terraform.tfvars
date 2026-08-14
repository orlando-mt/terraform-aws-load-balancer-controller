region       = "us-east-1"
cluster_name = "example-cluster"
vpc_id       = "vpc-00000000000000000"

# Take these from the EKS module outputs oidc_provider_arn / oidc_provider_url
oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EXAMPLE"
oidc_provider_url = "oidc.eks.us-east-1.amazonaws.com/id/EXAMPLE"

# Pin the chart version for reproducible rollouts
chart_version = "1.13.0"
replica_count = 2

tags = {
  Project   = "example"
  ManagedBy = "terraform"
}
