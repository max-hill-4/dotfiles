# Claude Code Setup

This instance runs via Ollama Cloud, not Anthropic directly.

- **Model:** `glm-5.1:cloud` (set via `/model`)
- **Env vars:** `ANTHROPIC_AUTH_TOKEN=ollama`, `ANTHROPIC_API_KEY=""` (empty), `ANTHROPIC_BASE_URL=http://localhost:11434`
- **Quick launch:** `ollama launch claude`
- **Inline launch:** `ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://localhost:11434 ANTHROPIC_API_KEY="" claude --model glm-5:cloud`
- **With specific model:** `ollama launch claude --model kimi-k2.5:cloud`
- **Headless/CI:** `ollama launch claude --model kimi-k2.5:cloud --yes -- -p "prompt"`
- **Recommended cloud models:** `glm-5:cloud`, `kimi-k2.5:cloud`, `minimax-m2.7:cloud`, `qwen3.5:cloud`
- **Recommended local models:** `qwen3.5`, `glm-4.7-flash`
- **Browse cloud models:** ollama.com/search?c=cloud
- **Context window:** 64k minimum recommended for Claude Code
- **Cloud model naming:** use `:cloud` suffix for local proxy; drop suffix for direct API
- **Direct API auth:** `OLLAMA_API_KEY` as Bearer token to `https://ollama.com/api/chat`
- **Local API:** `http://localhost:11434/api/chat` (cloud offload is automatic when using `:cloud` models)
- **SDK:** Python `ollama.Client(host="https://ollama.com", headers={"Authorization": "Bearer " + key})`; JS similar

# Environment & File Handling

- Connected via SSH to an Oracle Cloud ARM VPS — no local browser or GUI
- When the user needs to view/download a file, upload it via the transfer.sh container and give them a URL

## Upload Container (transfer.sh)

Used to share files that can't be easily displayed in a terminal (images, PDFs, spreadsheets, binaries, etc.).

**How to upload a file:**
```bash
curl --upload-file /path/to/file https://upload.maxh.work/file.txt
```
This returns a URL like `https://upload.maxh.work/RANDOM_ID/file.txt` — share that with the user.

**Details:**
- **Image:** `dutchcoders/transfer.sh`
- **Compose file:** `/home/eeg/upload/docker-compose.yml`
- **Data volume:** `/home/eeg/upload/data/` (persisted on disk)
- **Internal port:** 8080 → mapped to host 3012
- **Public URL:** `https://upload.maxh.work` (proxied via Caddy with TLS)
- **Max upload size:** 5 GB (set in Caddy)
- **Requires `sudo`** for Docker commands (`sudo docker …`)

**Quick patterns:**
```bash
# Single file
curl --upload-file /path/to/file https://upload.maxh.work/filename.ext

# Pipe output as a named file
some-command | curl --upload-file - https://upload.maxh.work/output.txt
```