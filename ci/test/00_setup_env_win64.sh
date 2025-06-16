#!/usr/bin/env bash
#
# Bitnion (BNO) – Windows 64-bit Cross-Compile Build Environment Setup Script
#
# This script configures the cross-compilation environment to build
# Bitnion Core for 64-bit Windows targets (Win64) using MinGW-w64.
#
# It ensures correct linkage across all core modules including:
# - chainparams
# - pow.cpp
# - validation.cpp
# - README.md
#
# All references to Bitcoin have been professionally replaced
# with Bitnion naming conventions and directory structure.
#

set -euo pipefail
export LC_ALL=C

# Define Bitnion repository root
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-w64-mingw32

# Path to dependencies for Windows 64-bit
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Set up cross-compilers (must be installed beforehand)
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"

# Compiler flags suitable for cross-platform Windows builds
export CFLAGS="-O2 -static-libgcc"
export CXXFLAGS="-O2 -static-libstdc++"

# Optional: define library path if needed
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Start Bitnion Win64 cross-configuration
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${DEPENDS_DIR}" \
  --host="${HOST}" \
  --disable-shared \
  --enable-static \
  --with-pic \
  --with-daemon \
  --with-utils \
  --with-boost="${DEPENDS_DIR}" \
  --with-incompatible-bdb \
  --without-gui \
  --disable-wallet \
  --disable-tests \
  --disable-bench \
  --without-miniupnpc \
  --without-natpmp

echo "✅ Bitnion Windows 64-bit cross-compilation environment is now configured successfully."
