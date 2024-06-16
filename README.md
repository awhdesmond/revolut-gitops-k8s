# Revolut Gitops-k8s

Gitops repository for K8s platform components as well as application services.

## Application Components

| Component    | Namespace        |
| ------------ | ---------------- |
| user-service | revolut-user-svc |

* `kustomize/apps/components/*`: Contains k8s manifests for deploying an app/component to kubernetes. It uses sub-directories to indicates which cluster to deploy those manifests.
* `kustomize/apps/setups/*`: Contains setups that are groups of related apps/components that should be deployed together to provide some functionality.

## Platform Components

| Component     | Namespace           |
| ------------- | ------------------- |
| ArgoCD        | platform-argocd     |
| Prometheus    | platform-monitoring |
| NGINX Ingress | platform-ingress    |

* `kustomize/platform/components/*`: Contains k8s manifests for deploying a platfrom component to kubernetes. It uses sub-directories to indicates which cluster to deploy those manifests.
* `kustomize/platform/setups/*`: Contains setups that are groups of related components that should be deployed together to provide some functionality.


## KinD

To deploy components locally, we can use KinD.

```bash
brew install kind
make kind
```

