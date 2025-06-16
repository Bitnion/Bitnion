#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up native fuzzing environment with Valgrind for Bitnion..."

# Install dependencies (Debian/Arch/CentOS-compatible)
if command -v apt-get >/dev/null 2>&1; then
  apt-get update && apt-get install -y clang llvm valgrind protobuf-compiler libprotobuf-dev
elif command -v pacman >/dev/null 2>&1; then
  pacman -Sy --noconfirm clang llvm valgrind protobuf
elif command -v yum >/dev/null 2>&1; then
  yum install -y clang llvm valgrind protobuf-compiler protobuf-devel
fi

# Compiler flags for fuzzing (Valgrind friendly)
export CC=clang
export CXX=clang++
export CFLAGS="-g -O1 -fno-omit-frame-pointer -DDEBUG"
export CXXFLAGS="$CFLAGS"
export LDFLAGS=""

# Configure build for fuzz with Valgrind tracking
export CONFIGURE_FLAGS="--enable-fuzz --disable-asm --disable-shared --with-sanitizers=memory"

# Confirm tool versions and system
clang --version
valgrind --version
uname -a

echo ">> Bitnion fuzzing environment with Valgrind is ready."
