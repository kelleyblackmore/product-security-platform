package psp

default allow := false

# Expected input:
# {
#   "sbom_present": true,
#   "signed": false,
#   "vulns": { "critical": 0, "high": 0, "medium": 0, "low": 0, "unknown": 0 },
#   "iac": { "failed": 0 },
#   "dast": { "high": 0, "medium": 0, "low": 0, "info": 0 },
#   "sast": { "alerts": 0 }
# }

deny[msg] {
  not input.sbom_present
  msg := "SBOM missing"
}

deny[msg] {
  input.vulns.critical > 0
  msg := sprintf("Critical vulnerabilities found: %d", [input.vulns.critical])
}

deny[msg] {
  input.iac.failed > 0
  msg := sprintf("IaC checks failing: %d", [input.iac.failed])
}

# For PRs, signed may be false; enforce signing on release pipelines.
deny[msg] {
  input.enforce_signed == true
  not input.signed
  msg := "Image must be signed"
}

deny[msg] {
  input.dast.high > 0
  msg := sprintf("DAST high findings: %d", [input.dast.high])
}

allow {
  count(deny) == 0
}
