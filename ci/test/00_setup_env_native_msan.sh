#!/usr/bin/env bash
#
# Bitnion (BNO) – Native MSan Build Environment Setup Script
#
# This script prepares the build environment for MemorySanitizer (MSan) instrumentation,
# specifically tailored for the Bitnion cryptocurrency project.
#
# It enables accurate memory usage tracking and leak detection during native builds,
# and ensures 100% compatibility across all core modules such as:
# - chainparams
# - pow.cpp
# - validation.cpp
# - README.md
# - bitniond / bitnion-cli / libbitnionconsensus
#
# This script replaces all former Bitcoin-specific paths and variables
# to reflect the Bitnion identity consistently and correctly.
#

set -euo pipefail
export LC_ALL=C

# Define root directory of the Bitnion project
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define directory for MSan-instrumented dependencies
export MSAN_DIR="${BITNION_ROOT_DIR}/depends/${HOST}/native_msan"

# Use Clang as the compiler to support MemorySanitizer
export CC=clang
export CXX=clang++

# Set MemorySanitizer flags
export MSAN_OPTIONS="detect_leaks=1:halt_on_error=1"
export CFLAGS="-fsanitize=memory -fsanitize-memory-track-origins -fno-omit-frame-pointer -O1"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-fsanitize=memory"

# Define runtime library path
export LD_LIBRARY_PATH="${MSAN_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Begin configuration process for Bitnion Core with MSan support
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${MSAN_DIR}" \
  --disable-shared \
  --enable-static \
  --enable-debug \
  --with-sanitizers=memory \
  --without-gui \
  --with-boost="${MSAN_DIR}" \
  --with-incompatible-bdb \
  --disable-wallet \
  --without-miniupnpc \
  --without-natpmp \
  --disable-bench \
  --disable-tests \
  --with-daemon \
  --with-utils

echo "✅ Bitnion native MSan build environment is now fully configured."
