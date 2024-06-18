# Revolut Gitops-k8s

Gitops repository for K8s platform components as well as application services.

## Platform Components

Platform components provide shared cluster-level functionalities and capabilities to support services deployed by product developers.

| Component         | Namespace        |
| ----------------- | ---------------- |
| AWS-LBC           | platform-cloud   |
| NGINX Ingress     | platform-ingress |
| Secrets Store CSI | platform-secrets |

`kustomize/platform/components/*`

* k8s manifests for deploying a platform component.
* Sub-directories indicates which environment to deploy.

`kustomize/platform/setups/*`

* Setups are groups of related components that should be deployed together to provide some functionality.
* Provides an ordering for deploying the components.


```bash
# Use the output from terraform: aws_lbc_role_arn
export AWS_LBC_ROLE_ARN=<aws_lbc_role_arn from terraform output>

./scripts/update-aws-fields-platform.sh

make platform KUBE_CONTEXT=${EKS_KUBECTL_CONTEXT}
```

## Application Components

| Component    | Namespace        |
| ------------ | ---------------- |
| user-service | revolut-user-svc |

`kustomize/apps/components/*`:

* k8s manifests for deploying an app/component to kubernetes.
* Sub-directories to indicates which environment to deploy those manifests.

`kustomize/apps/setups/*`

* Setups are groups of related components that should be deployed together to provide some functionality.
* Provides an ordering for deploying the components

```bash
export USER_SERVICE_ROLE_ARN=<revolut_user_service_role_arn from terraform >
export RDS_HOST=<first rds_hostnames from terraform>
export REDIS_URI=<elasticache_cluster_configuration_endpoint from terraform>

./scripts/update-aws-fields-user-service.sh

make user-service KUBE_CONTEXT=${EKS_KUBECTL_CONTEXT}
```
