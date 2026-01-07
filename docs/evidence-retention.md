# Evidence Retention

## Why
CMMC / NIST assessments require evidence that controls are operating consistently.

## What we retain
- SBOMs: `artifacts/sbom.*.json`
- Scan outputs: `artifacts/trivy.json`, `artifacts/grype.json`, `artifacts/checkov.json`
- DAST: `artifacts/zap.json`, `artifacts/zap.html`
- Policy decisions: `artifacts/opa-allow.json`, `artifacts/opa-deny.json`
- Release metadata: signed image references (Cosign transparency log)

## How to retain in a real org
- Store build artifacts in an immutable artifact store (S3/WORM or artifact registry attachments)
- Retain for >= 1 year (or per program requirement)
- Ensure artifacts are access-controlled (least privilege)

## Chain of custody
- Tie evidence to commit SHA + workflow run ID
- Maintain signed releases
- Preserve logs for auditing
