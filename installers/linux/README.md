# Linux Installer (Console — on-prem)

Native Linux installer for Device Management Toolkit (Console) on-prem.

**Status:** Not yet implemented.

## Scope

- `.deb`, `.rpm`, and shell-based options.
- x86_64 and arm64.
- systemd service integration.
- Idempotent reinstall and clean uninstall.

## Out of scope

- Cloud (use `bicep/` or `charts/` with `values-cloud.yaml`).
- Multi-host clustering (use `charts/` with `values-onprem.yaml`).
