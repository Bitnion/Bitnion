#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up macOS environment for Bitnion cross-build..."

# Check and install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install required dependencies
brew update
brew install autoconf automake libtool pkg-config coreutils cmake gnu-sed git

# Use GNU sed over BSD sed for compatibility
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Set up cross-compiler variables if necessary
export CC=clang
export CXX=clang++
export CONFIG_SITE=$PWD/depends/x86_64-apple-darwin/share/config.site

# Show environment summary
uname -a
sw_vers || true
clang --version

echo ">> macOS environment for Bitnion is ready."
