# Device Management Toolkit — Cloud Deployment

> **Looking for the legacy MPS-based deployment?** See the [`v2`](../../tree/v2) branch.

[![Discord](https://img.shields.io/discord/1063200098680582154?style=for-the-badge&label=Discord&logo=discord&logoColor=white&labelColor=%235865F2&link=https%3A%2F%2Fdiscord.gg%2FDKHeUNEWVH)](https://discord.gg/DKHeUNEWVH)

> Disclaimer: Production releases are tagged and listed under 'Releases'. Other check-ins should be considered in-development and should not be used in production.

This repo contains deployment artifacts for **Device Management Toolkit (Console)** — the unified service replacing the historical MPS+RPS split. Console can be deployed in either a **cloud**  or **on-prem** environment.

For detailed documentation, see the [docs site][docs].

## Clone

```bash
git clone --recursive https://github.com/device-management-toolkit/cloud-deployment.git
```

The `--recursive` flag is required — this repo uses git submodules under `services/`.

## Get Started

### Local development with Docker Compose

```bash
cp .env.template .env
# edit .env: set POSTGRES_PASSWORD, VAULT_TOKEN, AUTH_ADMIN_PASSWORD, AUTH_JWT_KEY, etc.
docker compose up -d
```

### Cloud (Azure) deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdevice-management-toolkit%2Fcloud-deployment%2Fmain%2FazureDeploy.json)

Or via Azure CLI:

```bash
az group create --name dmt-console --location eastus
az deployment group create --resource-group dmt-console --template-file azureDeploy.json
```

> Migration to Bicep is planned. The current ARM template is retained for compatibility.

### Cloud Kubernetes (AKS, GKE, EKS) with Helm

```bash
helm install console ./charts -f ./charts/values-cloud.yaml
```

Enables headless Console + sample-web-ui + kong API gateway + mps-router.

### On-prem Kubernetes with Helm

```bash
helm install console ./charts -f ./charts/values-onprem.yaml
```

Console with built-in UI; no kong, no sample-web-ui, no mps-router.

### On-prem native (macOS, Linux, Windows)

See [`installers/`](./installers) for native installer status.

## Repository Layout

- `services/` — git submodules (Console, RPS, sample-web-ui, mps-router).
- `azureDeploy.json` — Azure ARM deployment.
- `charts/` — Helm chart with `values-cloud.yaml` and `values-onprem.yaml` overlays.
- `installers/` — Console native installers (on-prem).
- `docker-compose.yml` — local-dev / cloud-style stack.

## Branches

- `main` (this branch) — v3 (Console-era), active development.
- `v2` — legacy MPS-era, minimum feature/maintenance only.

## Additional Resources

- [Documentation site][docs]
- [Open a new issue](./issues)
- [Security policy](SECURITY.md)
- [Discord](https://discord.gg/DKHeUNEWVH)

[docs]: https://device-management-toolkit.github.io/docs
