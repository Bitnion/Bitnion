#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up native ASan environment for Bitnion..."

# Install required packages if missing (Debian/Arch/CentOS-compatible)
if command -v apt-get >/dev/null 2>&1; then
  apt-get update && apt-get install -y clang lldb llvm
elif command -v pacman >/dev/null 2>&1; then
  pacman -Sy --noconfirm clang lldb llvm
elif command -v yum >/dev/null 2>&1; then
  yum install -y llvm llvm-devel clang
fi

# Set compiler flags for AddressSanitizer
export CC=clang
export CXX=clang++
export CFLAGS="-fsanitize=address -fno-omit-frame-pointer"
export CXXFLAGS="-fsanitize=address -fno-omit-frame-pointer"
export LDFLAGS="-fsanitize=address"

# Set configure options for Bitnion
export CONFIGURE_FLAGS="--enable-debug --disable-asm --with-sanitizers=address"

# Confirm compiler version and system info
clang --version
uname -a

echo ">> Native ASan environment setup for Bitnion complete."
