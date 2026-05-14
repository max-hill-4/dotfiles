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

# Environment & Hardware

- **Local machine:** WSL2 on Windows 11 desktop — RTX 5070, AMD 9800X3D, 64GB RAM
- **Platform:** Linux 6.6.87.2-microsoft-standard-WSL2
- WSL2 shares localhost with Windows — services on either side are accessible on `localhost`
- Blender runs on the Windows side; MCP servers in WSL connect to it over localhost
- When the user needs to view/download a file, copy it to their Windows Downloads directory:
  `cp /path/to/file /mnt/c/Users/maxwe/Downloads/`
  Then tell the user to check their Downloads folder.

# Image Analysis (Zen MCP + Nemotron Nano VL)

The Zen MCP server has a free vision model for analyzing images, charts, screenshots, and documents.

**Model:** `nvidia/nemotron-nano-12b-v2-vl:free` (alias: `nemo-vl`)
**Provider:** OpenRouter (free tier)
**Capabilities:** Image, text, and video input; chart reading; OCR; document understanding

**How to use:**
- Use any `mcp__zen__*` tool with `model: "nemo-vl"` and pass image paths in the `images` parameter
- Works with: `mcp__zen__chat`, `mcp__zen__thinkdeep`, `mcp__zen__analyze`, `mcp__zen__codereview`
- Example: `mcp__zen__chat` with `model: "nemo-vl"`, `images: ["/path/to/image.png"]`, `prompt: "Describe this image"`

**Other free Zen models (text only, no vision):**
| Alias | Model | Context |
|-------|-------|---------|
| `bp` | big-pickle | 200K |
| `mm-free` | minimax-m2.5-free | 1M |
| `nemo-free` | nemotron-3-super-free | 128K |
| `trinity` | trinity-large-preview-free | 128K |
| `nano` | gpt-5-nano | 128K |

**Config files:**
- Custom models: `/home/eeg/.pal/custom_models.json`
- OpenRouter models: `/home/eeg/.pal/openrouter_models.json`
- MCP env vars: `/home/eeg/.claude.json` (mcpServers.zen)

**Privacy:** The free Nemotron tier logs all prompts/outputs to NVIDIA. Don't send sensitive data.