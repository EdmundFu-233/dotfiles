#!/usr/bin/env bash
# Setup shell completions for commonly used tools
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
COMPLETION_DIR="$HOME/.local/share/bash-completion/completions"

mkdir -p "$COMPLETION_DIR"

install_completion() {
    local cmd="$1"
    local src="$DOTFILES_DIR/completions/${cmd}.bash"
    local dst="$COMPLETION_DIR/${cmd}"

    if command -v "$cmd" &>/dev/null; then
        if [ -f "$src" ]; then
            cp "$src" "$dst"
            echo "✓ $cmd completion installed"
        else
            # Generate from the command itself
            case "$cmd" in
                kubectl) kubectl completion bash > "$dst" 2>/dev/null && echo "✓ $cmd completion generated" || true ;;
                docker) docker completion bash > "$dst" 2>/dev/null && echo "✓ $cmd completion generated" || true ;;
                *) echo "  skipping $cmd (no source)" ;;
            esac
        fi
    fi
}

# Install completions for common tools
for tool in kubectl docker helm terraform make git gh; do
    install_completion "$tool"
done

echo "Completions setup complete. Restart your shell or run: exec bash"

