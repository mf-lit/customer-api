# TODO: Add status messaging to each step

.PHONY: test deps reqs lint docker-build docker-push deploy

deps: reqs ## Installs Python dependencies needed to run the project
	pip install --upgrade pip pip-tools
	pip-sync requirements.txt requirements-dev.txt

reqs: 
	pip-compile --no-emit-index-url
	pip-compile --no-emit-index-url requirements-dev.in

test: ## Runs the tests
	docker build -t customer-api:test --target test .
	docker run --rm customer-api:test pytest -v /app

lint: ## Basic linting/formatting of python, dockerfile and helm chart
	docker run -i --rm -v $(PWD):/io ghcr.io/astral-sh/ruff:0.1.13 .
	docker run --rm -v $(PWD)/src:/src --workdir /src pyfound/black:23.3.0 black --check --diff .
	docker run --rm -i hadolint/hadolint < Dockerfile
	docker run -i --rm -v $(PWD):/apps -w /apps alpine/helm template customer-api chart --values chart/values/kind.yaml 1>/dev/null

docker-build: # Build "production" image
	docker build -t customer-api:prod --target prod .

kind-start:
	@./kind/kind.sh

kind-stop:
	kind delete cluster --name test-cluster

docker-push:
	kind load docker-image customer-api:prod --name test-cluster

deploy:
	@for id in a b ; do \
	  echo ; \
		echo "==== Deploying customer-$$id" ; \
		echo ; \
		helm upgrade -i customer-api chart --create-namespace -n customer-$$id --values chart/values/kind.yaml --values chart/values/customer-$$id.yaml --wait ; \
		helm test customer-api -n customer-$$id ; \
	done

test-endpoints:
	@echo
	@echo "==== Testing endpoints"
	@for id in a b; do \
	  endpoint="http://localhost:8088/customer-$$id" ; \
		echo "$$endpoint: " ; \
		curl -s $$endpoint ; \
		echo ; echo ; \
	done

cicd: lint test docker-build docker-push deploy