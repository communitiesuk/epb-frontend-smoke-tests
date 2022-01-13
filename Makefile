PAAS_API ?= api.london.cloud.service.gov.uk
PAAS_ORG ?= mhclg-energy-performance
PAAS_SPACE ?= monitoring
DEPLOY_APPNAME ?= dluhc-epb-frontend-smoke-tests

define check_space
	@echo "Checking PaaS space is active..."
	$(if ${PAAS_SPACE},,$(error Must specify PAAS_SPACE))
	@[ $$(cf target | grep -i 'space' | cut -d':' -f2) = "${PAAS_SPACE}" ] || (echo "${PAAS_SPACE} is not currently active cf space" && exit 1)
endef

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: deploy-app
deploy-app: ## Deploys the app to PaaS
	$(call check_space)
	$(if ${DEPLOY_APPNAME},,$(error Must specify DEPLOY_APPNAME))

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