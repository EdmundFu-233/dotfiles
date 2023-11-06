#!/bin/bash
# Simple backup script
BACKUP_DIR="${HOME}/backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "Backing up to $BACKUP_DIR..."

# Backup dotfiles
cp -r "$HOME/.bashrc" "$BACKUP_DIR/"
cp -r "$HOME/.vimrc" "$BACKUP_DIR/"
cp -r "$HOME/.gitconfig" "$BACKUP_DIR/"

echo "Backup complete!"
