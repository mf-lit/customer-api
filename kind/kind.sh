#!/bin/bash
## A helper script to create a kind cluster and install ingress-nginx
## Usage: ./kind.sh

set -euo pipefail

CLUSTER_NAME="test-cluster"
CLUSTER_CONFIG_FILE="kind-config.yaml"


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for t in kind kubectl; do
    if ! command -v $t &> /dev/null ; then
        echo "ERROR: $t not found"
        exit 1
    fi
done

# Check if cluster exists, if not create it
if ! kind get clusters | grep -q "^${CLUSTER_NAME}$" ; then
    kind create cluster --name $CLUSTER_NAME --config ${SCRIPT_DIR}/${CLUSTER_CONFIG_FILE}
fi

kubectl cluster-info --context kind-$CLUSTER_NAME

# Install ingress-nginx if not already installed
if ! kubectl get deployment -n ingress-nginx ingress-nginx-controller >/dev/null 2>&1 ; then
    echo "Installing ingress-nginx"
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml 
fi
kubectl rollout status deployment.apps/ingress-nginx-controller -n ingress-nginx --timeout=90s
