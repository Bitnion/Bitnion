#!/usr/bin/env bash
#
# Bitnion (BNO) – Build Script (Stage A)
#
# This script performs the actual compilation and linking of Bitnion Core.
# It is meant to be executed after environment setup has been completed.
# All project references (files, names, modules) have been updated to match
# the Bitnion identity and structure, independently of the original Bitcoin codebase.
#
# Modules affected: chainparams, pow.cpp, validation.cpp, README.md, etc.

set -euo pipefail
export LC_ALL=C

echo "🛠 Starting Bitnion build script (stage A)..."

# Define Bitnion root path
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
cd "${BITNION_ROOT_DIR}"

# Optionally print Git commit info for traceability
if command -v git >/dev/null 2>&1; then
  echo "🔎 Git Commit: $(git rev-parse --short HEAD || echo unknown)"
fi

# Confirm existence of build scripts and autogen
if [[ ! -x ./autogen.sh ]]; then
  echo "❌ autogen.sh is missing or not executable."
  exit 1
fi

# Run autogen/configure only if Makefile is not present
if [[ ! -f ./Makefile ]]; then
  echo "⚙️ Generating build configuration..."
  ./autogen.sh
  ./configure --prefix="${BITNION_ROOT_DIR}/depends/x86_64-unknown-linux-gnu"
fi

# Build with maximum concurrency
echo "🚧 Running make -j$(nproc)..."
make -j"$(nproc)"

# Validate binary output
for bin in bitniond bitnion-cli bitnion-util; do
  if [[ -x "./src/${bin}" ]]; then
    echo "✅ ${bin} built successfully."
  else
    echo "❌ Failed to build ${bin}."
    exit 1
  fi
done

echo "✅ Bitnion build completed successfully."
