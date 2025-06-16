#!/usr/bin/env bash
set -euo pipefail

echo ">> Running lint before-script for Bitnion..."

# Print environment info
echo "Shell: $SHELL"
echo "User: $(whoami)"
echo "Working Directory: $(pwd)"

# Check versions of installed tools
command -v shellcheck && shellcheck --version || echo "shellcheck not found"
command -v flake8 && flake8 --version || echo "flake8 not found"
command -v clang-format && clang-format --version || echo "clang-format not found"

echo ">> Environment ready for Bitnion linting."
