#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up native fuzzing environment for Bitnion..."

# Install required packages (Debian/Arch/CentOS)
if command -v apt-get >/dev/null 2>&1; then
  apt-get update && apt-get install -y clang lld llvm libprotobuf-dev protobuf-compiler
elif command -v pacman >/dev/null 2>&1; then
  pacman -Sy --noconfirm clang lld llvm protobuf protobuf-c
elif command -v yum >/dev/null 2>&1; then
  yum install -y clang llvm protobuf-devel protobuf-compiler
fi

# Set fuzzing compiler options
export CC=clang
export CXX=clang++
export CFLAGS="-g -O1 -fsanitize=fuzzer-no-link,address -fno-omit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fsanitize=fuzzer,address"

# Configure flags for Bitnion fuzz build
export CONFIGURE_FLAGS="--enable-fuzz --disable-shared --with-sanitizers=fuzzer,address"

# Confirm versions and system info
clang --version
ld.lld --version || true
uname -a

echo ">> Native fuzzing environment setup for Bitnion complete."
