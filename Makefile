PAAS_API ?= api.london.cloud.service.gov.uk
PAAS_ORG ?= mhclg-energy-performance
PAAS_SPACE ?= monitoring

define check_space
	@echo "Checking PaaS space is active..."
	$(if ${PAAS_SPACE},,$(error Must specify PAAS_SPACE))
	@[ $$(cf target | grep -i 'space' | cut -d':' -f2) = "${PAAS_SPACE}" ] || (echo "${PAAS_SPACE} is not currently active cf space" && exit 1)
endef

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: generate-manifest
generate-manifest: ## Generate manifest file for PaaS
	$(if ${DEPLOY_APPNAME},,$(error Must specify DEPLOY_APPNAME))
	$(if ${PAAS_SPACE},,$(error Must specify PAAS_SPACE))
	@scripts/generate-paas-manifest.sh ${DEPLOY_APPNAME} ${PAAS_SPACE} > manifest.yml


.PHONY: deploy-app
deploy-app: ## Deploys the app to PaaS
	$(call check_space)
	$(if ${DEPLOY_APPNAME},,$(error Must specify DEPLOY_APPNAME))

	@$(MAKE) generate-manifest

	cf apply-manifest -f manifest.yml

	cf set-env "${DEPLOY_APPNAME}" BUNDLE_WITHOUT "test:worker"
	cf set-env "${DEPLOY_APPNAME}" STAGE "${PAAS_SPACE}"

	cf push "${DEPLOY_APPNAME}" --strategy rolling

.PHONY: test
test:
	@bundle exec rspec spec --format documentation

.PHONY: format
format:
	@bundle exec rubocop --auto-correct || true