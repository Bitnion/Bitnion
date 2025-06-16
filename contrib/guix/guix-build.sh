#!/usr/bin/env bash
#
# guix-build.sh — Deterministic build wrapper for Bitnion using Guix.
# Builds for Linux, Windows, and macOS.
# -----------------------------------------------------------------------------

set -euo pipefail

export BITNION_SRC_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
export GUIX_ENV_FILE="${BITNION_SRC_DIR}/contrib/guix/manifest.scm"
export GUIX_LIBEXEC="${BITNION_SRC_DIR}/contrib/guix/libexec"

# Check for Guix environment
if ! command -v guix >/dev/null 2>&1; then
    echo "Error: Guix is not installed or not in PATH."
    exit 1
fi

# Check args
if [ $# -lt 1 ]; then
    echo "Usage: ./guix-build.sh <target(s)>"
    echo "Available targets: linux x86_64-w64-mingw32 aarch64-apple-darwin x86_64-apple-darwin"
    exit 1
fi

# Enter the environment
echo "[guix-build] Entering Guix build container..."
guix environment -m "$GUIX_ENV_FILE" --pure -- ./contrib/guix/libexec/build.sh "$@"
