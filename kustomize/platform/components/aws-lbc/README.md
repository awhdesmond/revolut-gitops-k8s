# aws-lbc

The AWS Load Balancer controller (LBC) provisions AWS Network Load Balancer (NLB) and Application Load Balancer (ALB) resources. The LBC watches for new service or ingress Kubernetes resources and configures AWS resources.

The LBC is supported by AWS. Some clusters may be using the legacy "in-tree" functionality to provision AWS load balancers. The AWS Load Balancer Controller should be installed instead.

```bash
ROOT_DIR=$(git rev-parse --show-toplevel)

pushd ${ROOT_DIR}/kustomize/platform/components/aws-lbc
helm repo add eks https://aws.github.io/eks-charts
helm fetch \
    --untar \
    --untardir charts \
    eks/aws-load-balancer-controller

helm template \
    --output-dir base \
    --namespace platform-cloud \
    --set clusterName=eks \
    --set serviceAccount.name=aws-load-balancer-controller \
    aws-load-balancer-controller  \
    charts/aws-load-balancer-controller

mv base/aws-load-balancer-controller/templates base
rm -rf charts base/aws-load-balancer-controller

pushd base
kustomize create --autodetect --recursive
popd

popd
```

## References

* https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.8/deploy/installation/
