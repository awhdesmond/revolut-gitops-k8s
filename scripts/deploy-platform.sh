#!/bin/bash

set -exu

ROOT_DIR=$(git rev-parse --show-toplevel)
CONTEXT=${1-'kind-kind-1'}

kubectx ${CONTEXT}

# Only deploy metallb in local clusters
if [[ $CONTEXT == kind-* ]]; then
    echo "Deploying MetalLB"
    kubectl apply -k kustomize/platform/setups/02-networking/local || true
    sleep 5

    # MetalLB CRD is not installed, wait for deployment to be ready and reapply
    kubectl wait --namespace metallb-system \
        --selector=app=metallb \
        --for=condition=ready pod \
        --timeout=90s
    kubectl apply -k kustomize/platform/setups/02-networking/local
fi

for ns in platform-argocd platform-ingress
do
    kubectl create ns $ns || true
done

for setup in '03-ingress' '04-argocd'
do
    kubectl apply --server-side -k kustomize/platform/setups/${setup}/local || true
    sleep 5
done
