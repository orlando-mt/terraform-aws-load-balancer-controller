# Complete example

Installs the AWS Load Balancer Controller on an existing EKS cluster,
including the IRSA role and IAM policy.

The `helm` provider is configured against the cluster with `aws eks
get-token`, so the cluster must already exist before running this example.

## Usage

```bash
terraform init
terraform apply \
  -var "cluster_name=my-cluster" \
  -var "vpc_id=vpc-xxxx" \
  -var "oidc_provider_arn=arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/XXXX" \
  -var "oidc_provider_url=oidc.eks.us-east-1.amazonaws.com/id/XXXX"
```

## Verify

```bash
kubectl -n kube-system get deployment aws-load-balancer-controller
kubectl -n kube-system logs deploy/aws-load-balancer-controller
```
