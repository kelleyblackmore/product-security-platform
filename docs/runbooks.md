# Runbooks

## Handling a critical vulnerability
1. Confirm finding source (Trivy vs Grype) and affected package/version
2. Identify reachable code path (if applicable)
3. Patch by:
   - bumping dependency
   - rebuilding base image
   - or applying mitigation (config/rule)
4. Regenerate SBOM + scans
5. Ensure OPA allow returns true
6. Release with signed image

## Tuning scans to reduce noise
- Maintain ignore lists with expiration (time-bound exceptions)
- Prefer "warn in PR, fail in main" for noisy classes
- Track MTTR for criticals as a KPI
