# Product Security Platform (Shift-Left Reference)

This repository demonstrates how to embed product security into the SDLC:
- SAST, SCA, SBOM generation
- Container & IaC scanning
- Policy-as-code gating (OPA)
- Image signing (Cosign) and evidence retention
- Basic shared authn/authz and logging primitives
- CMMC Level 2 / NIST 800-171 mapping and evidence artifacts

## Quick Start
```bash
make tools
make build
make scan