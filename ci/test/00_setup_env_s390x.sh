#!/usr/bin/env bash
#
# Bitnion (BNO) – s390x Cross-Compile Build Environment Setup Script
#
# This script configures the Bitnion Core build system for cross-compilation
# targeting IBM Z (s390x) architecture. It ensures full project linkage between:
# - chainparams
# - validation.cpp
# - pow.cpp
# - README.md
# - bitniond / bitnion-cli / bitnion-util
#
# All references to Bitcoin have been renamed to Bitnion,
# guaranteeing branding and consistency across source, output, and binaries.
#

set -euo pipefail
export LC_ALL=C

# Define Bitnion project root
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=s390x-linux-gnu

# Set output path for dependencies
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Set cross-compiler (ensure s390x toolchain is installed)
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"

# Flags compatible with cross-compiling
export CFLAGS="-O2 -fPIC"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS=""

# Set runtime library path if needed
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Begin Bitnion Core configuration for s390x target
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

echo "✅ Bitnion cross-compilation environment for s390x has been successfully configured."
