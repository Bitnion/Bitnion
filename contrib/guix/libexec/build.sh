#!/usr/bin/env bash
#
# build.sh — Internal Guix build logic for Bitnion.
# Called from guix-build.sh
# -----------------------------------------------------------------------------

set -euo pipefail

echo "[guix-libexec] Starting Bitnion build..."

cd "$(dirname "$0")/../../.."

./autogen.sh
./configure --disable-tests --without-gui --prefix="$(pwd)/depends/$1"

make -j"$(nproc)"

echo "[guix-libexec] Bitnion build completed for target: $1"
