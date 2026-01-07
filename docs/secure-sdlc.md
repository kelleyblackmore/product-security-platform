# Secure SDLC

## PR Stage (fast feedback)
- Unit tests
- SAST (CodeQL)
- SBOM generation
- Container scan (Trivy/Grype)
- IaC scan (Checkov)
- DAST baseline (ZAP)
- OPA policy evaluation (informational gates)

## Main Stage (stronger enforcement)
- Same scans
- Optional: enforce failure thresholds on critical findings
- Artifact retention (evidence)
- Promotion rules (recommended)

## Release Stage
- Build + push image to registry
- Generate SBOM for release artifact
- Sign image with Cosign keyless
- Enforce OPA gate (signed must be true)
