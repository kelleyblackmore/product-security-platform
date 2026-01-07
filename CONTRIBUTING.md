# Contributing

## Principles
- Prefer security controls that are automated and produce evidence artifacts.
- Avoid adding "checkbox" scans that do not map to a control or a risk decision.

## Development
```bash
make test
make build
```

## Adding a new control
1. Add the tool integration in CI
2. Emit a machine-readable report into artifacts/
3. Update scripts/summarize_policy_input.py
4. Update OPA gate if it should affect allow/deny
5. Add the control mapping in docs/cmmc-nist-mapping.md
