# ArgoCD

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. Argo CD follows the **GitOps** pattern of using Git repositories as the source of truth for defining the desired application state.

Argo CD automates the deployment of the desired application states in the specified target environments. Application deployments can track updates to branches, tags, or pinned to a specific version of manifests at a Git commit.

```bash
# Get default password. The default user is 'admin'
kubectl -n platform-argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d

kubectl -n platform-argocd port-forward svc/argocd-server 8080:443
```

> ArgoCD by default uses a self-signed certificate.
