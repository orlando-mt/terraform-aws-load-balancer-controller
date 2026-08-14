# Complete example

Installs the AWS Load Balancer Controller on an existing EKS cluster,
including the IRSA role and IAM policy.

The `helm` provider is configured against the cluster with `aws eks
get-token`, so the cluster must already exist before running this example.

Replace the cluster name, VPC and OIDC values in
[`terraform.tfvars`](./terraform.tfvars) with your own.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Verify

```bash
kubectl -n kube-system get deployment aws-load-balancer-controller
kubectl -n kube-system logs deploy/aws-load-balancer-controller
```
