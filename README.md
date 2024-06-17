# Revolut Gitops-k8s

Gitops repository for K8s platform components as well as application services.

## Platform Components

Platform components provide shared cluster-level functionalities and capabilities to support services deployed by product developers.

| Component     | Namespace        |
| ------------- | ---------------- |
| ArgoCD        | platform-argocd  |
| AWS-LBC       | platform-cloud   |
| NGINX Ingress | platform-ingress |

`kustomize/platform/components/*`

Contains k8s manifests for deploying a platform component to kubernetes. It uses sub-directories to indicates which cluster to deploy those manifests.

`kustomize/platform/setups/*`

Contains setups that are groups of related components that should be deployed together to provide some functionality.

```bash
./scripts/deploy-platform.sh <KUBECTL_CONTEXT>


# Get default password. The default user is 'admin'
kubectl -n platform-argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d

kubectl -n platform-argocd port-forward svc/argocd-server 8080:443
```

## Application Components

| Component    | Namespace        |
| ------------ | ---------------- |
| user-service | revolut-user-svc |

`kustomize/apps/components/*`:

Contains k8s manifests for deploying an app/component to kubernetes. It uses sub-directories to indicates which cluster to deploy those manifests.

`kustomize/apps/setups/*`

Contains setups that are groups of related apps/components that should be deployed together to provide some functionality.

```bash
./scripts/deploy-user-service.sh <KUBECTL_CONTEXT>
```

## Local KinD

We will use [KinD](https://kind.sigs.k8s.io/) to bootstrap a local kubernetes cluster and deploy components into it.

```bash
brew install kind
make clusters
```
