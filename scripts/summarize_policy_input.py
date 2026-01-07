import argparse
import json
from pathlib import Path
from typing import Any, Dict

def safe_load_json(path: Path) -> Any:
    if not path.exists():
        return None
    return json.loads(path.read_text())

def summarize_trivy(trivy: Dict[str, Any]) -> Dict[str, int]:
    counts = {"critical": 0, "high": 0, "medium": 0, "low": 0, "unknown": 0}
    if not trivy:
        return counts

    # Trivy JSON schema varies by mode; commonly Results[*].Vulnerabilities[*].Severity
    results = trivy.get("Results", []) or []
    for r in results:
        vulns = r.get("Vulnerabilities") or []
        for v in vulns:
            sev = (v.get("Severity") or "UNKNOWN").lower()
            if sev in counts:
                counts[sev] += 1
            else:
                counts["unknown"] += 1
    return counts

def summarize_grype(grype: Dict[str, Any]) -> Dict[str, int]:
    counts = {"critical": 0, "high": 0, "medium": 0, "low": 0, "unknown": 0}
    if not grype:
        return counts

    # Grype: matches[*].vulnerability.severity (case-insensitive)
    matches = grype.get("matches", []) or []
    for m in matches:
        v = (m.get("vulnerability") or {})
        sev = (v.get("severity") or "Unknown").lower()
        if sev in counts:
            counts[sev] += 1
        else:
            counts["unknown"] += 1
    return counts

def summarize_checkov(checkov: Dict[str, Any]) -> int:
    if not checkov:
        return 0

    # Checkov JSON: may include "results": {"failed_checks": [...]}
    results = checkov.get("results") or {}
    failed = results.get("failed_checks") or []
    return len(failed)

def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--trivy", type=str, required=False, default="")
    ap.add_argument("--grype", type=str, required=False, default="")
    ap.add_argument("--checkov", type=str, required=False, default="")
    ap.add_argument("--sbom", type=str, required=False, default="")
    ap.add_argument("--out", type=str, required=True)
    ap.add_argument("--signed", action="store_true")
    ap.add_argument("--enforce-signed", action="store_true")
    args = ap.parse_args()

    trivy = safe_load_json(Path(args.trivy)) if args.trivy else None
    grype = safe_load_json(Path(args.grype)) if args.grype else None
    checkov = safe_load_json(Path(args.checkov)) if args.checkov else None

    sbom_present = Path(args.sbom).exists() if args.sbom else False

    trivy_counts = summarize_trivy(trivy if isinstance(trivy, dict) else {})
    grype_counts = summarize_grype(grype if isinstance(grype, dict) else {})

    # Combine counts (simple sum). In real orgs you'd pick a single source of truth or de-dup.
    vulns = {k: trivy_counts[k] + grype_counts[k] for k in trivy_counts.keys()}

    policy_input = {
        "sbom_present": sbom_present,
        "signed": bool(args.signed),
        "enforce_signed": bool(args.enforce_signed),
        "vulns": vulns,
        "iac": {"failed": summarize_checkov(checkov if isinstance(checkov, dict) else {})},
        "dast": {"high": 0, "medium": 0, "low": 0, "info": 0},
        "sast": {"alerts": 0},
    }

    Path(args.out).write_text(json.dumps(policy_input, indent=2))

if __name__ == "__main__":
    main()
