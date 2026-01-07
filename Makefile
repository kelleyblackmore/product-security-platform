SHELL := /bin/bash

APP_DIR := app/service
ARTIFACTS := artifacts

.PHONY: clean test build run sbom scan policy dast

clean:
	rm -rf $(ARTIFACTS)

test:
	cd $(APP_DIR) && python -m pip install -U pip >/dev/null
	cd $(APP_DIR) && pip install . pytest >/dev/null
	cd $(APP_DIR) && pytest -q

build:
	docker build -t psp/service:dev $(APP_DIR)

run:
	docker run --rm -p 8080:8080 psp/service:dev

sbom:
	mkdir -p $(ARTIFACTS)
	syft psp/service:dev -o cyclonedx-json > $(ARTIFACTS)/sbom.cdx.json
	syft psp/service:dev -o spdx-json > $(ARTIFACTS)/sbom.spdx.json

scan:
	mkdir -p $(ARTIFACTS)
	trivy image --exit-code 0 --format json -o $(ARTIFACTS)/trivy.json psp/service:dev
	grype psp/service:dev -o json > $(ARTIFACTS)/grype.json
	checkov -d infra/terraform --output json > $(ARTIFACTS)/checkov.json || true

policy:
	mkdir -p $(ARTIFACTS)
	python scripts/summarize_policy_input.py \
	  --trivy $(ARTIFACTS)/trivy.json \
	  --grype $(ARTIFACTS)/grype.json \
	  --checkov $(ARTIFACTS)/checkov.json \
	  --sbom $(ARTIFACTS)/sbom.cdx.json \
	  --out $(ARTIFACTS)/policy-input.json
	opa eval -I -d policies/opa/build-gate.rego -i $(ARTIFACTS)/policy-input.json "data.psp.deny" > $(ARTIFACTS)/opa-deny.json
	opa eval -I -d policies/opa/build-gate.rego -i $(ARTIFACTS)/policy-input.json "data.psp.allow" > $(ARTIFACTS)/opa-allow.json

dast:
	mkdir -p $(ARTIFACTS)
	# expects service running on localhost:8080
	zap-baseline.py -t http://localhost:8080 -J $(ARTIFACTS)/zap.json -r $(ARTIFACTS)/zap.html || true