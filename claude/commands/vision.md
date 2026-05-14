Send an image file to a vision-capable Ollama cloud model for analysis. Usage: /vision <image_path> [question]

This opens a separate request to qwen3-vl:235b-cloud (dedicated vision model, highest accuracy) via curl, so it doesn't interfere with the current Claude Code session.

Steps:
1. The user will provide: /vision <image_path> [optional question]
2. Read the image file from the provided path
3. If the image is PNG with transparency (RGBA), convert to RGB first, then save as JPEG
4. Base64 encode the image
5. Send a request to the Ollama Anthropic API at http://localhost:11434/v1/messages using qwen3-vl:235b-cloud with max_tokens 1500
6. If no question is provided, default to "Describe this image in detail. What do you see?"
7. Print the model's full response

Important:
- Always use qwen3-vl:235b-cloud as the default model (highest accuracy, zero hallucinations on text/table data)
- NEVER use local models on this device (too slow/resource-heavy)
- Do NOT use glm-5.1:cloud (no vision support)
- Use the Anthropic Messages API format with image content blocks
- Run the curl command via Bash - do not switch the session model
- The user can specify a different model by adding --model <name> to the command