#!/usr/bin/env bash
#
# install_db4.sh - Install Berkeley DB 4.8 for Bitnion wallet compatibility
#
# This script builds and installs Berkeley DB 4.8.30 with static linking
# as required by the Bitnion Core wallet. It ensures deterministic behavior
# and avoids any system-wide library conflicts.
#
# License: MIT
# Project: Bitnion Core

set -e

BITNION_ROOT=$(pwd)
BDB_PREFIX="${BITNION_ROOT}/db4"
BDB_VERSION="db-4.8.30.NC"
BDB_URL="http://download.oracle.com/berkeley-db/${BDB_VERSION}.tar.gz"
BDB_SHA256="12edc0b23b45824e109c38e0f1a0d2d10a3f3d1c218845c482e9e5f74b7b62f4"

echo "[+] Creating working directory..."
mkdir -p "${BDB_PREFIX}"

cd /tmp
echo "[+] Downloading Berkeley DB ${BDB_VERSION}..."
curl -O -L "${BDB_URL}"

echo "[+] Verifying checksum..."
echo "${BDB_SHA256}  ${BDB_VERSION}.tar.gz" | sha256sum -c

echo "[+] Extracting..."
tar -xzvf "${BDB_VERSION}.tar.gz"

cd "${BDB_VERSION}/build_unix"

echo "[+] Configuring build for Bitnion..."
../dist/configure \
  --prefix="${BDB_PREFIX}" \
  --enable-cxx \
  --disable-shared \
  --with-pic \
  --disable-replication

echo "[+] Building..."
make -j$(nproc)
make install

echo "[✅] Berkeley DB 4.8 installed successfully to: ${BDB_PREFIX}"
echo "    Add the following flags when building Bitnion Core:"
echo
echo "    CPPFLAGS=\"-I${BDB_PREFIX}/include\""
echo "    LDFLAGS=\"-L${BDB_PREFIX}/lib\""
