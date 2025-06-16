#!/usr/bin/env bash
#
# Bitnion (BNO) – Native Valgrind-Compatible Build Environment Setup Script
#
# This script configures a full native build environment for Bitnion Core
# with debugging symbols and optimizations suited for memory analysis via Valgrind.
# It ensures clean linkage between all project components:
# - chainparams
# - pow.cpp
# - validation.cpp
# - README.md
#
# All configurations have been adapted from Bitcoin Core but rewritten to match
# Bitnion’s structure, terminology, and naming conventions.
#

set -euo pipefail
export LC_ALL=C

# Define Bitnion project root directory
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define dependency output directory
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Use standard GCC compiler for debugging
export CC=gcc
export CXX=g++

# Enable debug symbols, disable aggressive optimization for Valgrind
export CFLAGS="-g -O1"
export CXXFLAGS="${CFLAGS}"

# Set library path for runtime execution
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Start configuration process
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${DEPENDS_DIR}" \
  --disable-shared \
  --enable-static \
  --enable-debug \
  --with-pic \
  --without-gui \
  --disable-wallet \
  --disable-tests \
  --disable-bench \
  --with-daemon \
  --with-utils \
  --with-incompatible-bdb \
  --with-boost="${DEPENDS_DIR}" \
  --without-natpmp \
  --without-miniupnpc

echo "✅ Bitnion native Valgrind-compatible build environment is now fully configured."
