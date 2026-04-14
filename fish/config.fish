# Add ~/.local/bin to PATH
fish_add_path ~/.local/bin

# Claude alias for ollama
alias claude='ollama launch claude --model glm-5.1:cloud'

# eza with file icons
alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lt='eza --tree --icons --level=2'
alias ltt='eza --tree --icons'

if status is-interactive
    # Accept autosuggestion on Enter instead of needing Right-arrow first
    bind \r accept-autosuggestion execute
end
