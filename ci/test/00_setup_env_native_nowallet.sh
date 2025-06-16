#!/usr/bin/env bash
#
# Bitnion (BNO) – Native No-Wallet Build Environment Setup Script
#
# This script sets up a wallet-free build environment for the Bitnion project.
# It is optimized for lightweight nodes or systems that do not require
# on-chain wallet functionality. All files and configurations are designed
# to work seamlessly across modules such as:
# - chainparams
# - pow.cpp
# - validation.cpp
# - README.md
#
# It guarantees consistency, integrity, and project correctness under the
# Bitnion namespace — not Bitcoin — to ensure full independence and clarity.
#

set -euo pipefail
export LC_ALL=C

# Define the root directory of the Bitnion repository
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define path to Bitnion's dependency output
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Use standard system compilers
export CC=gcc
export CXX=g++

# Compilation flags for optimized native builds
export CFLAGS="-O2"
export CXXFLAGS="${CFLAGS}"

# Set runtime library path
export LD_LIBRARY_PATH="${DEPENDS_DIR}/lib:${LD_LIBRARY_PATH:-}"

# Begin Bitnion configuration without wallet functionality
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
  --without-miniupnpc \
  --without-natpmp

echo "✅ Bitnion native no-wallet build environment is now fully configured."
