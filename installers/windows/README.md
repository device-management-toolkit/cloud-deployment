# Windows Installer (Console — on-prem)

Native Windows installer for Device Management Toolkit (Console) on-prem.

**Status:** Not yet implemented.

## Scope

- `.msi` (WiX) primary, optional standalone `.exe`.
- x86_64.
- Windows Service registration.
- Idempotent reinstall and clean uninstall.

## Out of scope

- Cloud (use `bicep/` or `charts/` with `values-cloud.yaml`).
- Multi-host clustering (use `charts/` with `values-onprem.yaml`).
