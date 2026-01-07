# CMMC Level 2 / NIST 800-171 Mapping (Evidence Driven)

This repo is designed to demonstrate how SDLC controls produce audit-ready evidence.

## SI (System & Information Integrity)
- SI-2 Flaw Remediation
  - Implementation: Trivy/Grype scans in CI + policy gate
  - Evidence: artifacts/trivy.json, artifacts/grype.json, artifacts/opa-allow.json

- SI-3 Malicious Code Protection (supporting)
  - Implementation: CodeQL SAST scans in PR
  - Evidence: GitHub Security Code Scanning alerts

## SC (System & Communications Protection)
- SC-13 Cryptographic Protection
  - Implementation: TLS termination assumed at ingress; mTLS optional (future)
  - Evidence: k8s manifests and ingress config (placeholder)

## AC (Access Control) / IA (Identification & Authentication)
- AC-3 / IA-2
  - Implementation: service enforces Bearer token; production would validate JWT using JWKS and enforce claims
  - Evidence: app/service/src/libs/auth.py and tests