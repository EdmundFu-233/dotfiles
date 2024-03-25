#!/bin/bash
# Log rotation script
LOG_DIR="${1:-/var/log}"
DAYS="${2:-7}"

echo "Rotating logs older than $DAYS days in $LOG_DIR..."

find "$LOG_DIR" -name "*.log" -type f -mtime "+$DAYS" -exec gzip {} \;
find "$LOG_DIR" -name "*.gz" -type f -mtime "+$((DAYS * 2))" -delete

echo "Log rotation complete!"
