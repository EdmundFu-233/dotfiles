#!/bin/bash
# Auto-sync git repositories
REPOS_DIR="$HOME/projects"

for dir in "$REPOS_DIR"/*/; do
    if [ -d "$dir/.git" ]; then
        echo "Syncing $dir..."
        cd "$dir"
        git pull --rebase
        git push
    fi
done

echo "All repositories synced!"
