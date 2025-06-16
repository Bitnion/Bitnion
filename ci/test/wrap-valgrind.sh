#!/usr/bin/env bash
#
# Bitnion (BNO) – Valgrind Execution Wrapper Script
#
# This script wraps a Bitnion Core binary with Valgrind to perform
# runtime memory analysis, leak checking, and access validation.
#
# Originally based on Bitcoin Core test utilities, now adapted for
# Bitnion project naming, structure, and execution paths.
#

set -euo pipefail
export LC_ALL=C

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <bitnion-binary> [args...]"
  echo "Example: ./wrap-valgrind.sh ./src/bitniond --version"
  exit 1
fi

TARGET_BINARY="$1"
shift

if [[ ! -x "${TARGET_BINARY}" ]]; then
  echo "❌ Error: '${TARGET_BINARY}' is not executable."
  exit 1
fi

if ! command -v valgrind >/dev/null 2>&1; then
  echo "❌ Error: valgrind is not installed or not in PATH."
  exit 1
fi

echo "🔍 Running under Valgrind: ${TARGET_BINARY} $@"
exec valgrind \
  --leak-check=full \
  --show-leak-kinds=all \
  --track-origins=yes \
  --error-exitcode=42 \
  "${TARGET_BINARY}" "$@"
