---
name: VPS Environment
description: Machine is an Oracle Cloud free-tier ARM VPS — specs and constraints
type: user
originSessionId: a835e9f5-8f70-4f45-b4f1-548e22bd22e9
---
This machine is a VPS running on Oracle Cloud's **Always Free ARM tier**.

**Specs:**
- Architecture: aarch64 (ARM64)
- CPU: 4x Neoverse-N1 (1 thread/core, 1 socket)
- RAM: ~24 GB
- Storage: ~45 GB disk (expandable via OCI block volumes)
- Swap: none
- OS: Linux (Oracle Cloud Ubuntu/Debian variant)

**Implications:**
- ARM64 only — no x86/amd64 binaries; use `aarch64` or `arm64` packages
- No swap means memory-hungry builds can OOM; prefer swap-heavy workloads elsewhere or add swap
- Free tier has bandwidth and CPU burst limits — avoid sustained max-CPU workloads
- Disk space is tight (~12 GB free) — clean up aggressively, avoid large local caches

**Reverse Proxy:**
- Caddy running in a Docker container
- Domain: **maxh.work** — DNS managed via Cloudflare
- Caddy handles automatic TLS (via Cloudflare DNS-01 challenge)

**Access & File Handling:**
- Connected via SSH — no local browser or GUI
- When the user needs to view/download a file, use the **upload** Docker container to host it so they can download it via browser
- The upload container serves files over HTTP on the VPS — put/copy the file into the container's volume and give the user the URL