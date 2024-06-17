#!/bin/bash

set -exu

ROOT_DIR=$(git rev-parse --show-toplevel)
CLUSTER=${1-'kind-1'}

echo "Creating cluster $CLUSTER"
kind create cluster -n $CLUSTER --config=clusters/${CLUSTER}.yaml || true
