#!/usr/bin/env bash
#
# Bitnion (BNO) – Post-Build Installation Script
#
# This script installs Bitnion Core binaries and headers after a successful build.
# It ensures that all output components are placed consistently across the project tree,
# and that required files are available for downstream usage (e.g., packaging or deployment).
#
# Fully adapted from Bitcoin Core CI pipelines, rewritten for Bitnion project integration.
#
# Affected modules: chainparams, pow.cpp, validation.cpp, README.md, etc.

set -euo pipefail
export LC_ALL=C

echo "📦 Starting Bitnion installation phase..."

# Define root path
BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
cd "${BITNION_ROOT_DIR}"

# Optional destination path (can be extended or customized)
INSTALL_PREFIX="${BITNION_ROOT_DIR}/build/install"

# Create target directory if needed
mkdir -p "${INSTALL_PREFIX}"

# Perform installation (uses Makefile-generated install target)
make install DESTDIR="${INSTALL_PREFIX}"

# Log installed binaries for verification
echo "📄 Installed binaries:"
find "${INSTALL_PREFIX}" -type f -executable -print

# Validate key output components
for bin in bitniond bitnion-cli bitnion-util; do
  if [[ ! -f "${INSTALL_PREFIX}/usr/local/bin/${bin}" && ! -f "${INSTALL_PREFIX}/bin/${bin}" ]]; then
    echo "⚠️ Warning: ${bin} not found in expected install path."
  else
    echo "✅ ${bin} installed successfully."
  fi
done

echo "✅ Bitnion installation completed successfully."
