# Customer API

## Overview

A Flask application that responds to GET requests with a simple plain-text response. The response itself is passed to the application via environment variable `$CUSTOMER_RESPONSE`

The application is packaged as a Docker image, and then deployed to a local Kubernetes cluster using a Helm chart. In fact the application is deployed twice (for Customer A and Customer B) into namespaces `customer-a` and `customer-b` respectively.

Once deployed, application endpoints are exposed at:
`http://<cluster-ip>:<cluster-port>/customer-<a|b>/`

## Prerequisites

 - Docker
 - A local Kubernetes cluster with an Ingress-Controller (a [helper script](kind/kind.sh) is included for spinning-up a cluster (called `test-cluster`) using Kind)
 - Kubectl
 - Helm

## Quick-start

 If pre-requisites are met it should be possible to run the full CI/CD pipeline and start two instances of the application using `make cicd`

## Usage

A [Makefile](Makefile) is included with the following targets:

 - `lint` Basic linting of python code and Dockerfile
 - `test` Runs any tests using pytest
 - `docker-build`: Builds a docker image ready for "Production"
 - `docker-push` Pushes the docker image to the local Kind cluster registry (depends on a local Kubernetes cluster)
 - `deploy`: Deploys the Helm chart for two customers (depends on a local Kubernetes cluster)
 - `cicd` Runs all the above, emulating a complete CI/CD pipeline 
 - `kind-start`: Starts a kind cluster and a Nginx Ingress-Controller
 - `kind-stop`: Stops kind cluster
 - `test-endpoints`: cURLs both customer-endpoints for demonstration purposes
 - `deps` Installs Python dependencies needed to run the application locally

## Testing

Pytest unit tests are included in [/tests](tests)

Helm tests are included in the [chart](chart/templates/tests)

## Docker 

A [Dockerfile](Dockerfile) for packaging the application is included

## Kubernetes

A local cluster running an Ingress-Controller is required. A [helper script](kind/kind.sh) is included for spinning this up using Kind.

## Helm

A Helm [chart](chart) is included, configuration details are in the Chart [README](chart/README.md)

Customer-specific [values files](chart/values) are used to configure customer applications

