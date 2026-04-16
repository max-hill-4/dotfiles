# Completions for Claude Code CLI
set -l commands config continue init login logout migrate resume update

# Disable file completions by default
complete -c claude -f

# Top-level flags
complete -c claude -s c -l continue -d "Continue the most recent conversation"
complete -c claude -s r -l resume -d "Resume a previous conversation"
complete -c claude -s p -l print -d "Non-interactive mode, output to stdout"
complete -c claude -s h -l help -d "Display help"
complete -c claude -s V -l version -d "Show version"
complete -c claude -l debug -d "Enable debug mode"
complete -c claude -l verbose -d "Enable verbose output"
complete -c claude -l dangerousously-skip-permissions -d "Skip all permission checks"
complete -c claude -l ide -d "Connect to IDE on startup"
complete -c claude -l chat -d "Start in chat mode"

# Subcommands
complete -c claude -n "__fish_use_subcommand" -a config -d "Manage configuration"
complete -c claude -n "__fish_use_subcommand" -a init -d "Initialize project"
complete -c claude -n "__fish_use_subcommand" -a login -d "Log in to Claude"
complete -c claude -n "__fish_use_subcommand" -a logout -d "Log out of Claude"
complete -c claude -n "__fish_use_subcommand" -a migrate -d "Migrate settings"
complete -c claude -n "__fish_use_subcommand" -a update -d "Update Claude Code"
complete -c claude -n "__fish_use_subcommand" -a resume -d "Resume a conversation"