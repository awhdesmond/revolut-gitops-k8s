#!/bin/bash

set -exu

ROOT_DIR=$(git rev-parse --show-toplevel)
CONTEXT=${1-'kind-kind-1'}

kubectx ${CONTEXT}

[[ $CONTEXT == kind-* ]] && ENV=local || ENV=prod

for ns in platform-argocd platform-ingress platform-secrets platform-cloud
do
    kubectl create ns $ns || true
done

if [[ $ENV == prod ]]; then
    # Enable prefix mode for VPC-CNI
    # https://aws.amazon.com/blogs/containers/amazon-vpc-cni-increases-pods-per-node-limits/
    kubectl set env daemonset aws-node -n kube-system ENABLE_PREFIX_DELEGATION=true
fi

# Setup networking

kubectl apply -k kustomize/platform/setups/02-load-balancers/$ENV || true
sleep 5

if [[ $ENV == local ]]; then
    # MetalLB CRD is not installed, wait for deployment to be ready and reapply
    kubectl wait --namespace metallb-system \
        --selector=app=metallb \
        --for=condition=ready pod \
        --timeout=90s
    kubectl apply -k kustomize/platform/setups/01-networking/$ENV
fi

for setup in '03-ingress' '04-argocd' '05-secrets-store'
do
    kustomize_path=kustomize/platform/setups/${setup}/$ENV
    if [[ -d $kustomize_path ]]; then
        kubectl apply -k kustomize/platform/setups/${setup}/$ENV || true
        sleep 5
    fi
done
