# Revolut Gitops-k8s

Gitops repository for K8s platform components as well as application services.

## Platform Components

Platform components provide shared cluster-level functionalities and capabilities to support services deployed by product developers.

| Component         | Namespace        |
| ----------------- | ---------------- |
| AWS-LBC           | platform-cloud   |
| NGINX Ingress     | platform-ingress |
| ArgoCD            | platform-argocd  |
| Secrets Store CSI | platform-secrets |

`kustomize/platform/components/*`

* k8s manifests for deploying a platform component.
* Sub-directories indicates which environment to deploy.

`kustomize/platform/setups/*`

* Setups are groups of related components that should be deployed together to provide some functionality.
* Provides an ordering for deploying the components.


```bash
# Change to your aws-lbc role arn
export AWS_LBC_ROLE_ARN=arn:aws:iam::974860574511:role/eks-aws-lbc

sed -i '' \
    -e "s|eks.amazonaws.com\/role-arn:.*|eks.amazonaws.com/role-arn: ${AWS_LBC_ROLE_ARN}|g" \
    kustomize/platform/components/aws-lbc/base/templates/serviceaccount.yaml

make platform <KUBECTL_CONTEXT> <ENV>
```

> `ENV` is either `prod` or `local`

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
./scripts/deploy-user-service.sh <KUBECTL_CONTEXT> <ENV>
```

> `ENV` is either `prod` or `local`


## Local KinD

We will use [KinD](https://kind.sigs.k8s.io/) to bootstrap a local kubernetes cluster and deploy components into it.

```bash
brew install kind
make kind
```
