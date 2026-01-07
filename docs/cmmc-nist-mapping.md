# CMMC Level 2 / NIST 800-171 Mapping (Evidence Driven)

This mapping focuses on control families emphasized in the job description: AC, IA, SC, SI.

## SI - System & Information Integrity
### SI-2 Flaw Remediation
- Implementation: Trivy/Grype scans + OPA gate
- Evidence: artifacts/trivy.json, artifacts/grype.json, artifacts/opa-allow.json

### SI-3 Malicious Code Protection (supporting)
- Implementation: CodeQL SAST on PRs
- Evidence: GitHub Code Scanning alerts + workflow outputs

## SC - System & Communications Protection
### SC-13 Cryptographic Protection (supporting pattern)
- Implementation: platform terminates TLS at ingress; future: mTLS service mesh
- Evidence: platform configs (out of scope for this repo) + architecture doc references

### SC-7 Boundary Protection (K8s boundary analog)
- Implementation: NetworkPolicy default deny + allow-only ingress port
- Evidence: infra/kubernetes/manifests/networkpolicy.yaml

## AC - Access Control
### AC-3 Access Enforcement (application boundary)
- Implementation: bearer token requirement in API middleware
- Evidence: app/service/src/libs/auth.py + tests

### AC-6 Least Privilege (platform boundary)
- Implementation: minimal RBAC role + rolebinding
- Evidence: infra/kubernetes/manifests/rbac.yaml

## IA - Identification & Authentication
### IA-2 Identification and Authentication
- Implementation: token-based auth stub; production would validate JWT via JWKS
- Evidence: auth library + secure SDLC docs describing production path

## Supply chain / provenance (supports multiple families)
- Implementation: SBOM generation + cosign signing
- Evidence: artifacts/sbom.cdx.json + release workflow logs + cosign transparency log