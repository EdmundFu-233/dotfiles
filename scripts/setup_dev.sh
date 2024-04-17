#!/bin/bash
# Development environment setup
set -e

echo "Setting up development environment..."

# Install essential tools
sudo apt-get install -y \
    build-essential \
    curl \
    git \
    vim \
    tmux \
    htop \
    tree \
    jq

# Install Python packages
pip3 install --upgrade pip
pip3 install virtualenv black flake8 pytest

# Install Go
if ! command -v go &> /dev/null; then
    wget -q https://go.dev/dl/go1.21.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.21.linux-amd64.tar.gz
    rm go1.21.linux-amd64.tar.gz
fi

# Install Rust
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

echo "Development environment setup complete!"
