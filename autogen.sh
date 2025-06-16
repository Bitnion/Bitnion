#!/bin/sh
# =============================================================================
# Bitnion (BNO) – Autogen Script
#
# ▪ Name:         Bitnion
# ▪ Version:      1.0.0
# ▪ License:      MIT
# ▪ Developer:    Bitnion Core Team (anonymous)
#
# This script prepares the build system for Bitnion using GNU autotools.
# It replaces Bitcoin Core's build branding and sets Bitnion's custom system.
#
# ⚠️ Bitnion is NOT a token, investment, or financial product.
# Contact: bitnion@gmail.com
# =============================================================================

set -e

echo "Initializing Bitnion Core build environment..."

# Check for required autotools
AUTORECONF=$(which autoreconf)
if [ -z "$AUTORECONF" ]; then
  echo "Error: autoreconf not found. Please install autotools." >&2
  exit 1
fi

# Run autoreconf to generate configure script and related files
autoreconf --install --force --warnings=all

echo "Autogen complete."
echo "You can now run: ./configure && make -j2"
