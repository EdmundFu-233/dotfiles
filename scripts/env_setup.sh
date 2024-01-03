#!/bin/bash
# Environment setup script
export PROJECT_ROOT="$HOME/projects"
export PYTHONPATH="$PROJECT_ROOT:$PYTHONPATH"
export PATH="$PROJECT_ROOT/scripts:$PATH"

echo "Environment configured!"
echo "PROJECT_ROOT=$PROJECT_ROOT"
