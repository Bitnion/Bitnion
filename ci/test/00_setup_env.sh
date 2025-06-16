#!/usr/bin/env bash
#
# Bitnion (BNO) – Core Build Environment Initialization Script
#
# This script initializes the standard build environment for Bitnion Core.
# It is intended to be the primary setup entry point and ensures the correct
# paths, tools, and flags are applied for a successful native compilation.
#
# All Bitcoin references have been fully replaced with Bitnion
# to maintain consistency across build, documentation, and source structure.
#
# Related modules: chainparams, pow.cpp, validation.cpp, README.md, etc.
#

set -euo pipefail
export LC_ALL=C

# Define root directory of the Bitnion source tree
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define the output directory for built dependencies
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Select system compilers (customize if using cross-compilation)
export CC=gcc
export CXX=g++

# Basic compiler flags for native optimized build
export CFLAGS="-O2"
export CXXFLAGS="${CFLAGS}"

# Library path for runtime linking
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Start Bitnion configuration
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${DEPENDS_DIR}" \
  --disable-shared \
  --enable-static \
  --with-pic \
  --without-gui \
  --disable-wallet \
  --disable-tests \
  --disable-bench \
  --with-daemon \
  --with-utils \
  --with-boost="${DEPENDS_DIR}" \
  --with-incompatible-bdb \
  --without-natpmp \
  --without-miniupnpc

echo "✅ Bitnion standard build environment has been successfully configured."
