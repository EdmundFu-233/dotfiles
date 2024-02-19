#!/bin/bash
# System monitoring script
while true; do
    clear
    echo "=== System Monitor ==="
    echo "Time: $(date)"
    echo ""
    echo "--- CPU ---"
    top -bn1 | head -5
    echo ""
    echo "--- Memory ---"
    free -h
    echo ""
    echo "--- Disk ---"
    df -h / /home
    echo ""
    echo "--- Network ---"
    ss -tuln | head -10
    echo ""
    sleep 5
done
