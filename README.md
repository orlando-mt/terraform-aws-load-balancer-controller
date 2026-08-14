# terraform-aws-load-balancer-controller

Terraform module to install the [AWS Load Balancer Controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller) on an EKS cluster, together with its IRSA role and IAM policy.

## What this controller does

It watches Kubernetes resources and provisions AWS load balancers for them:

- **`Ingress` with `ingressClassName: alb`** → an **Application Load Balancer**, with routing rules derived from the Ingress paths.
- **`Service` of type `LoadBalancer`**  → a **Network Load Balancer**. This is the path used when running an in-cluster ingress controller such as ingress-nginx: the NLB fronts the nginx service, and nginx handles HTTP routing inside the cluster.

Both modes need this controller installed; which one you use is a per-workload decision, not a module setting.

## Features

- Helm release with configurable chart version, namespace, replica count and arbitrary extra values
- IRSA role scoped to the controller's service account (`system:serviceaccount:<namespace>:aws-load-balancer-controller`) with the `aud` condition
- **Tag-scoped IAM policy**: destructive actions (delete/modify load balancers, target groups and security groups) are conditioned on the `elbv2.k8s.aws/cluster` tag the controller sets, so it cannot touch load balancers it did not create
- `iam_policy_json` override to track a newer upstream policy without waiting for a module release
- **No kubernetes provider required** — the chart creates the service account with the IRSA annotation

## Usage

```hcl
module "load_balancer_controller" {
  source = "github.com/orlando-mt/terraform-aws-load-balancer-controller?ref=v1.0.0"

  cluster_name = module.eks.cluster_name
  region       = var.region
  vpc_id       = module.vpc.vpc_id

  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url

  chart_version = "1.13.0"

  tags = {
    Project   = "my-project"
    ManagedBy = "terraform"
  }
}
```

> **Subnet tagging:** the controller discovers subnets by tag. Public subnets need `kubernetes.io/role/elb = 1` and private subnets `kubernetes.io/role/internal-elb = 1`. Without those tags, load balancer provisioning fails with a subnet discovery error.

> **Provider configuration:** the `helm` provider must be pointed at the cluster (see the [complete example](./examples/complete)). Because that configuration depends on the cluster existing, keep this module in a separate apply from the one that creates the cluster, or run it after the cluster is up.

## Examples

- [Complete](./examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.9.0 |
| aws | >= 5.0 |
| helm | >= 2.12, < 3.0 |

## Resources

| Name | Type |
|------|------|
| helm_release.this | resource |
| aws_iam_role.this | resource |
| aws_iam_policy.this | resource |
| aws_iam_role_policy_attachment.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | EKS cluster name | `string` | n/a | yes |
| region | AWS region | `string` | n/a | yes |
| vpc_id | VPC of the cluster | `string` | n/a | yes |
| oidc_provider_arn | Cluster OIDC provider ARN | `string` | n/a | yes |
| oidc_provider_url | Cluster OIDC issuer URL | `string` | n/a | yes |
| role_name | IRSA role name | `string` | `null` (derived) | no |
| policy_name | IAM policy name | `string` | `null` (derived) | no |
| iam_policy_json | Policy override | `string` | `null` | no |
| release_name | Helm release name | `string` | `"aws-load-balancer-controller"` | no |
| chart_version | Chart version | `string` | `null` (latest) | no |
| namespace | Install namespace | `string` | `"kube-system"` | no |
| replica_count | Controller replicas | `number` | `2` | no |
| timeout | Helm timeout (seconds) | `number` | `600` | no |
| helm_values | Extra Helm values | `map(string)` | `{}` | no |
| tags | Tags for IAM resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam_role_arn / iam_role_name | IRSA role |
| iam_policy_arn | Controller policy |
| service_account_name / namespace | Service account location |
| release_name / release_status / chart_version | Helm release |
<!-- END_TF_DOCS -->

## License

MIT. See [LICENSE](./LICENSE).
