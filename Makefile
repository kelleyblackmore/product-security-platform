SHELL := /bin/bash

APP_DIR := app/service
ARTIFACTS := artifacts

.PHONY: tools build test sbom scan policy

tools:
	@mkdir -p tools $(ARTIFACTS)
	@echo "Install tools locally if desired:"
	@echo "  - syft, grype, trivy, opa, checkov, tfsec, cosign, zap"

build:
	@docker build -t psp/service:dev $(APP_DIR)

test:
	@cd $(APP_DIR) && python -m pytest -q

sbom:
	@mkdir -p $(ARTIFACTS)
	@echo "Generate SBOM (CycloneDX + SPDX) for container image"
	@syft psp/service:dev -o cyclonedx-json > $(ARTIFACTS)/sbom.cdx.json
	@syft psp/service:dev -o spdx-json > $(ARTIFACTS)/sbom.spdx.json

scan:
	@mkdir -p $(ARTIFACTS)
	@echo "Container scan (Trivy + Grype)"
	@trivy image --exit-code 0 --format json -o $(ARTIFACTS)/trivy.json psp/service:dev
	@grype psp/service:dev -o json > $(ARTIFACTS)/grype.json
	@echo "IaC scan"
	@checkov -d infra/terraform --output json > $(ARTIFACTS)/checkov.json || true
	@tfsec infra/terraform --format json > $(ARTIFACTS)/tfsec.json || true

policy:
	@mkdir -p $(ARTIFACTS)
	@echo "OPA policy gate evaluates scan results"
	@opa eval -I -d policies/opa/build-gate.rego \
	  -i $(ARTIFACTS)/policy-input.json \
	  "data.psp.allow" > $(ARTIFACTS)/opa-decision.json