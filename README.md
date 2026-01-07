# Product Security Platform (Shift-Left Reference)

This repo demonstrates a practical Product Security approach for cloud services:
- SAST (CodeQL)
- SCA + SBOM generation (Syft)
- Container scanning (Trivy + Grype)
- IaC scanning (Checkov)
- Policy-as-code gating (OPA)
- DAST (OWASP ZAP baseline)
- Artifact signing (Cosign keyless)
- Evidence retention and CMMC L2 / NIST 800-171 mapping

## Quick Start (local)
### Prereqs
- Docker
- Python 3.12+
- Optional tools for local runs: syft, trivy, grype, opa, checkov, zap

### Run
```bash
make test
make build
make scan
make policy
```

## CI/CD
- `.github/workflows/ci-security.yml` runs on PRs + main
- `.github/workflows/release.yml` signs images on tags v*

## Compliance + Evidence

See:
- [docs/cmmc-nist-mapping.md](docs/cmmc-nist-mapping.md)
- [docs/evidence-retention.md](docs/evidence-retention.md)
- [docs/secure-sdlc.md](docs/secure-sdlc.md)

## What to demo in interviews
- Pull request gates driven by OPA
- Evidence artifacts stored from each run
- Threat model + trust boundaries mapped to controls