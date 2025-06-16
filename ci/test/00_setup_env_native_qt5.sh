#!/usr/bin/env bash
#
# Bitnion (BNO) – Native Qt5 GUI Build Environment Setup Script
#
# This script sets up a clean and fully integrated native build environment
# for Bitnion Core with Qt5 GUI support enabled. It ensures that all core
# modules — including chainparams, pow.cpp, validation.cpp, and README.md —
# are properly linked, functional, and aligned under the Bitnion identity.
#
# This script is intended for use in GUI desktop environments or developer
# machines requiring the Bitnion-Qt interface.
#

set -euo pipefail
export LC_ALL=C

# Define the root of the Bitnion source repository
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
export HOST=x86_64-unknown-linux-gnu

# Define the path to Bitnion dependency builds
export DEPENDS_DIR="${BITNION_ROOT_DIR}/depends/${HOST}"

# Select compiler
export CC=gcc
export CXX=g++

# Compilation flags
export CFLAGS="-O2"
export CXXFLAGS="${CFLAGS}"

# Qt5 paths (assumes compiled via depends system)
export QT_INCLUDE_PATH="${DEPENDS_DIR}/include"
export QT_LIBRARY_PATH="${DEPENDS_DIR}/lib"

# Library path for runtime
export LD_LIBRARY_PATH="${QT_LIBRARY_PATH}:${LD_LIBRARY_PATH:-}"

# Run configuration with Qt5 GUI enabled
cd "${BITNION_ROOT_DIR}"

./autogen.sh

./configure \
  --prefix="${DEPENDS_DIR}" \
  --disable-shared \
  --enable-static \
  --with-pic \
  --with-gui=qt5 \
  --with-daemon \
  --with-utils \
  --with-incompatible-bdb \
  --with-qt-includes="${QT_INCLUDE_PATH}" \
  --with-qt-libs="${QT_LIBRARY_PATH}" \
  --with-boost="${DEPENDS_DIR}" \
  --without-natpmp \
  --without-miniupnpc \
  --disable-wallet \
  --disable-tests \
  --disable-bench

echo "✅ Bitnion native Qt5 GUI build environment is now fully configured."
