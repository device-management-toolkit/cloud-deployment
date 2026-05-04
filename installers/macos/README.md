# macOS Installer (Console — on-prem)

Native macOS installer for Device Management Toolkit (Console) on-prem.

**Status:** Not yet implemented.

## Scope

- `.pkg` or shell-based installer that provisions Console + dependencies (postgres, vault) on a single macOS host.
- Apple Silicon and Intel.
- Idempotent reinstall and clean uninstall.

## Out of scope

- Cloud (use `bicep/` or `charts/` with `values-cloud.yaml`).
- Multi-host clustering (use `charts/` with `values-onprem.yaml` on a k8s cluster).
