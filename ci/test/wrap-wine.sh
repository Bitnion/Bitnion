#!/usr/bin/env bash
#
# Bitnion (BNO) – Wine Execution Wrapper for Windows Binaries
#
# This script wraps the execution of cross-compiled Bitnion Windows binaries
# using Wine. It allows seamless testing of .exe builds generated via
# MinGW (e.g., x86_64-w64-mingw32) on Unix-like systems.
#
# Adapted from Bitcoin Core infrastructure, rewritten for the Bitnion project.
#

set -euo pipefail
export LC_ALL=C

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <bitnion-binary.exe> [args...]"
  echo "Example: ./wrap-wine.sh ./src/bitniond.exe --version"
  exit 1
fi

TARGET_BINARY="$1"
shift

if [[ ! -f "${TARGET_BINARY}" ]]; then
  echo "❌ Error: '${TARGET_BINARY}' not found."
  exit 1
fi

if ! command -v wine >/dev/null 2>&1; then
  echo "❌ Error: Wine is not installed or not in PATH."
  exit 1
fi

echo "🍷 Executing Windows binary under Wine: ${TARGET_BINARY} $@"
exec wine "${TARGET_BINARY}" "$@"
