#!/bin/bash
# Port forwarding utility
LOCAL_PORT="${1:-8080}"
REMOTE_HOST="${2:-example.com}"
REMOTE_PORT="${3:-80}"

echo "Forwarding localhost:$LOCAL_PORT -> $REMOTE_HOST:$REMOTE_PORT"
ssh -L "$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT" -N "$REMOTE_HOST"
