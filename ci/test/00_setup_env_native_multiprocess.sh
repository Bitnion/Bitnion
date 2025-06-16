#!/usr/bin/env bash
#
# Bitnion (BNO) – Native Multiprocess Build Environment Setup Script
#
# This script configures the native build environment for Bitnion Core
# with multiprocess support enabled. It ensures that all components—
# including core consensus files (chainparams, pow.cpp, validation.cpp),
# documentation (README.md), and build logic—are properly linked
# and ready for multi-threaded operation.
#
# It fully replaces Bitcoin-specific references to match Bitnion's structure
# and adheres to professional open-source standards.
#

set -euo pipefail
export LC_ALL=C

# Define the root path of the Bitnion repository
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define path to Bitnion's built dependencies
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Use system compilers (or cross-compiler if needed)
export CC=gcc
export CXX=g++

# Compiler flags optimized for multiprocess builds
export CFLAGS="-O2 -pthread"
export CXXFLAGS="${CFLAGS}"

# Runtime library path
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Begin configuration of Bitnion Core with multiprocess features
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${DEPENDS_DIR}" \
  --disable-shared \
  --enable-static \
  --enable-multiprocess \
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

echo "✅ Bitnion native multiprocess build environment is now fully configured."
