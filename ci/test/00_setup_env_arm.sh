#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up environment for Bitnion build on ARM..."

# Install dependencies for ARM (Debian/Arch variants)
if command -v apt-get >/dev/null 2>&1; then
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git ca-certificates
elif command -v pacman >/dev/null 2>&1; then
  pacman -Sy --noconfirm base-devel curl git pkgconf
else
  echo "Unsupported package manager. Please install dependencies manually."
  exit 1
fi

# Set build environment variables
export CC=clang
export CXX=clang++
export CONFIG_SITE=$PWD/depends/arm-linux-gnueabihf/share/config.site

# Confirm architecture
uname -a
lscpu || true

echo ">> Environment setup for Bitnion on ARM completed."
