#!/bin/bash

set -exu

CONTEXT=${1-local}
ENV=${2-prod}

kubectx ${CONTEXT}

for ns in platform-ingress platform-secrets platform-cloud amazon-cloudwatch
do
    kubectl create ns $ns || true
done

# Enable prefix mode for VPC-CNI
# https://aws.amazon.com/blogs/containers/amazon-vpc-cni-increases-pods-per-node-limits/
echo "Enabling vpc-cni ENABLE_PREFIX_DELEGATION"
kubectl set env daemonset aws-node -n kube-system ENABLE_PREFIX_DELEGATION=true

# Set up load balancers
# Need to deploy aws-lbc crds first
kubectl apply -k kustomize/platform/setups/01-aws-lbc-crds/$ENV || true


# Foundational components
for setup in '02-load-balancers' '03-ingress' '04-logging' '05-secrets-store'
do
    kustomize_path=kustomize/platform/setups/${setup}/$ENV
    if [[ -d $kustomize_path ]]; then
        kubectl apply -k kustomize/platform/setups/${setup}/$ENV || true
        sleep 10
    fi
done
