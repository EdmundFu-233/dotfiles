#!/bin/bash
# System update script
set -e

echo "=== System Update ==="

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Upgrade packages
echo "Upgrading packages..."
sudo apt-get upgrade -y

# Clean up
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "=== Update Complete ==="
