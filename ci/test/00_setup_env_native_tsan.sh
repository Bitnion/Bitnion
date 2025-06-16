#!/usr/bin/env bash
#
# Bitnion (BNO) – Native ThreadSanitizer (TSan) Build Environment Setup Script
#
# This script configures a native build environment for Bitnion Core
# using ThreadSanitizer (TSan) to detect data races and concurrency issues.
# It ensures full linkage between all relevant components:
# - chainparams
# - pow.cpp
# - validation.cpp
# - README.md
#
# All former Bitcoin references have been replaced to ensure full Bitnion branding.
# The configuration supports accurate diagnostics and high code quality across builds.
#

set -euo pipefail
export LC_ALL=C

# Define the root directory of Bitnion source
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define path to Bitnion dependency output
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Use Clang for TSan instrumentation
export CC=clang
export CXX=clang++

# ThreadSanitizer flags
export TSAN_OPTIONS="halt_on_error=1:report_signal_unsafe=1"
export CFLAGS="-fsanitize=thread -fno-omit-frame-pointer -O1"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-fsanitize=thread"

# Set library path for runtime
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Begin Bitnion TSan-enabled configuration
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${DEPENDS_DIR}" \
  --disable-shared \
  --enable-static \
  --enable-debug \
  --with-sanitizers=thread \
  --without-gui \
  --disable-wallet \
  --disable-tests \
  --disable-bench \
  --with-daemon \
  --with-utils \
  --with-boost="${DEPENDS_DIR}" \
  --with-incompatible-bdb \
  --without-miniupnpc \
  --without-natpmp

echo "✅ Bitnion native ThreadSanitizer (TSan) build environment is now fully configured."
