#!/bin/bash

set -exu

CONTEXT=${1-'kind-kind-1'}
ENV=prod

kubectl create ns revolut || true

kubectx ${CONTEXT}

kubectl apply -k kustomize/apps/setups/user-service/$ENV/eks
