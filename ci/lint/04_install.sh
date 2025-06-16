#!/usr/bin/env bash
set -euo pipefail

export LC_ALL=C.UTF-8

echo ">> Installing linting tools for Bitnion..."

# Install shellcheck for linting shell scripts
if ! command -v shellcheck > /dev/null 2>&1; then
  echo "Installing shellcheck..."
  apt-get update && apt-get install -y shellcheck
fi

# Install flake8 for Python linting if needed
if ! command -v flake8 > /dev/null 2>&1; then
  echo "Installing flake8..."
  pip install flake8
fi

# Optional: Install clang-format if C++ lint is needed
if ! command -v clang-format > /dev/null 2>&1; then
  echo "Installing clang-format..."
  apt-get install -y clang-format
fi

echo ">> Lint tools installed successfully for Bitnion."
