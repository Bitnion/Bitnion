#!/usr/bin/env bash
#
# Bitnion (BNO) – Pre-Installation Script for Build Environment Setup
#
# This script prepares the system prior to building Bitnion Core.
# It ensures that all dependencies and environment assumptions are validated
# before invoking the configure and make stages.
#
# Adapted from the Bitcoin Core CI suite and rewritten to fully support
# the Bitnion project structure, naming, and source code layout.
#
# Relevant modules: chainparams, pow.cpp, validation.cpp, README.md, etc.

set -euo pipefail
export LC_ALL=C

echo "🔧 Starting Bitnion pre-install setup..."

# Ensure required directories exist
mkdir -p ~/.bitnion
mkdir -p ~/bitnion/depends
mkdir -p ~/bitnion/build

# Update system packages (optional for CI automation)
# Uncomment for environments where sudo is allowed
# sudo apt update -y
# sudo apt install -y build-essential clang pkg-config git python3

# Display host details for debug
echo "System Architecture: $(uname -m)"
echo "Operating System:   $(uname -s)"
echo "Build User:         $(whoami)"
echo "Working Directory:  $(pwd)"

# Confirm that Bitnion repository structure exists
if [[ ! -f ~/bitnion/README.md ]] || [[ ! -d ~/bitnion/src ]] || [[ ! -f ~/bitnion/configure.ac ]]; then
  echo "❌ Error: Bitnion source tree not found. Please clone or initialize properly."
  exit 1
fi

# Check if autogen and configure scripts exist
if [[ ! -x ~/bitnion/autogen.sh ]]; then
  echo "❌ Error: Missing or non-executable autogen.sh in Bitnion root."
  exit 1
fi

echo "✅ Bitnion pre-install checks completed successfully."
