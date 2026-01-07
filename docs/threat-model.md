# Threat Model (Practical)

## System
A small API service deployed to Kubernetes, built and released via GitHub Actions.

## Key Assets
- Source code & build workflow integrity
- Container images and their provenance
- Secrets/tokens used for auth
- Logs and security events
- Terraform configurations

## Threats (selected)
### Supply Chain
- Malicious dependency (typosquatting)
- Compromised base image
- Workflow tampering / runner compromise

Controls:
- SCA + SBOM
- Container scanning
- Signed images (Cosign)
- Required reviews + branch protections (recommended)

### API Abuse
- Missing auth
- Injection issues (future expansions)
- Broken access control

Controls:
- Auth middleware primitive
- SAST (CodeQL) + secure coding practices

### Lateral Movement
- Over-permissive RBAC
- Open egress / wide network access

Controls:
- Default deny NetworkPolicy
- Minimal RBAC
- Secure pod security context

## Assumptions
- Ingress/TLS termination is handled by platform (can be expanded to mTLS)
- Secrets are managed by a platform secret manager (not stored in repo)
