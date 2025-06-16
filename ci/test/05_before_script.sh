#!/usr/bin/env bash
#
# Bitnion (BNO) – Pre-Script Runtime Environment Setup
#
# This script runs before any build/test script during CI execution.
# It prepares and validates the runtime environment, exports relevant variables,
# and confirms tool availability for compiling and linking Bitnion Core.
#
# This version is adapted from the Bitcoin Core suite and customized
# for the Bitnion project and directory structure.
#

set -euo pipefail
export LC_ALL=C

echo "⚙️ Preparing Bitnion runtime environment (before_script)..."

# Confirm system architecture and host
echo "System Architecture: $(uname -m)"
echo "Operating System:    $(uname -s)"
echo "Bitnion User:        $(whoami)"
echo "Working Directory:   $(pwd)"

# Define and export environment variables if not already set
export BITNION_ROOT_DIR="${BITNION_ROOT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)}"
export HOST="${HOST:-x86_64-unknown-linux-gnu}"
export DEPENDS_DIR="${DEPENDS_DIR:-${BITNION_ROOT_DIR}/depends/${HOST}}"
export PATH="${DEPENDS_DIR}/bin:${PATH}"

# Display Git info for debug (optional)
if command -v git >/dev/null 2>&1; then
  echo "Git Commit: $(git -C "${BITNION_ROOT_DIR}" rev-parse --short HEAD || echo unknown)"
fi

# Show available compiler versions
echo "Compiler Version (CC): $(${CC:-gcc} --version | head -n1)"
echo "Compiler Version (CXX): $(${CXX:-g++} --version | head -n1)"

# Verify Bitnion autogen/configure files
if [[ ! -x "${BITNION_ROOT_DIR}/autogen.sh" ]]; then
  echo "❌ Missing autogen.sh in ${BITNION_ROOT_DIR}"
  exit 1
fi

if [[ ! -f "${BITNION_ROOT_DIR}/configure.ac" ]]; then
  echo "❌ Missing configure.ac in ${BITNION_ROOT_DIR}"
  exit 1
fi

echo "✅ Bitnion environment initialized. Ready to execute build scripts."
