# Changelog

## [1.0.0] - 2026-07-30

### Added
- Initial release: AWS Load Balancer Controller installed via Helm with
  its IRSA role and IAM policy
- Service account created by the chart with the IRSA annotation, so the
  kubernetes provider is not required
- Tag-scoped IAM policy (elbv2.k8s.aws/cluster) instead of unconditional
  delete/modify permissions, with an override for newer upstream versions
- Configurable chart version, namespace, replicas and extra Helm values
