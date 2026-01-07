# Architecture

## Goal
Provide a reference implementation for embedding security controls into the SDLC with audit-ready evidence.

## Components
- Service: FastAPI demo workload (auth + logging primitives)
- CI: GitHub Actions pipeline producing SBOM + scan reports
- Policy Gate: OPA evaluates evidence artifacts and produces allow/deny decision outputs
- Release: Cosign keyless signing for images

## Evidence Flow
PR / main pipeline emits:
- SBOMs (CycloneDX, SPDX)
- Container vuln reports (Trivy, Grype)
- IaC findings (Checkov)
- DAST findings (ZAP baseline)
- Policy decisions (OPA allow/deny)

These artifacts become compliance evidence and are referenced in `docs/cmmc-nist-mapping.md`.

## Trust Boundaries
1. Client -> Service (requires token)
2. Service -> Platform (logging/telemetry and downstream deps)
3. CI/CD -> Artifact Registry (signed images + SBOM)
