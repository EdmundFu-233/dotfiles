#!/bin/bash
# Setup shell completions and readline enhancements

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

echo "Setting up shell enhancements..."

# Install .inputrc if not present
if [ ! -f "$HOME/.inputrc" ]; then
    if [ -f "$DOTFILES_DIR/config/inputrc" ]; then
        ln -sf "$DOTFILES_DIR/config/inputrc" "$HOME/.inputrc"
        echo "  ✓ Linked .inputrc (readline configuration)"
    fi
fi

# Source the file in bashrc if not already there
BASHRC="$HOME/.bashrc"
INPUTRC_LINE='bind -f "$HOME/.inputrc" 2>/dev/null'
if [ -f "$BASHRC" ] && ! grep -q "inputrc" "$BASHRC" 2>/dev/null; then
    echo "" >> "$BASHRC"
    echo "# Readline configuration" >> "$BASHRC"
    echo "$INPUTRC_LINE" >> "$BASHRC"
    echo "  ✓ Added inputrc sourcing to .bashrc"
fi

echo "Done! Restart your shell or run: source ~/.bashrc"
