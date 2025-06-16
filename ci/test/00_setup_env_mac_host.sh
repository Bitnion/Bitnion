#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up environment for Bitnion build on macOS host..."

# Check for Homebrew and install if missing
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update and install required packages
brew update
brew install autoconf automake libtool pkg-config coreutils cmake git

# Set environment variables for compiler and build system
export CC=clang
export CXX=clang++

# Confirm build system
uname -a
sw_vers || true

echo ">> Environment setup for Bitnion on macOS completed."
