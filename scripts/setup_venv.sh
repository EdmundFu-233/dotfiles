#!/bin/bash
# Setup Python virtual environment
PROJECT_NAME="${1:-myproject}"

python3 -m venv "$PROJECT_NAME/venv"
source "$PROJECT_NAME/venv/bin/activate"
pip install --upgrade pip

if [ -f "$PROJECT_NAME/requirements.txt" ]; then
    pip install -r "$PROJECT_NAME/requirements.txt"
fi

echo "Virtual environment created in $PROJECT_NAME/venv"
echo "Run: source $PROJECT_NAME/venv/bin/activate"
