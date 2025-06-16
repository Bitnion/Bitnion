#!/usr/bin/env bash
# Bitnion (BNO) – Binary Verification Script
#
# This script verifies that all Bitnion binaries provided in a release
# match their corresponding SHA256 checksums and are properly signed.

set -e

RELEASE=${1:-"v1.0.0"}
SIGNER=${2:-"bitnion"}
SHA256_SUMS="SHA256SUMS"
SHA256_SUMS_ASC="$SHA256_SUMS.asc"

echo ""
echo "🔒 Bitnion Binary Verification – Release: $RELEASE"
echo "----------------------------------------------------"

# Download SHA256SUMS and signature file
echo "📥 Downloading checksums and signature files..."
wget -N https://bitnion.org/bin/$RELEASE/$SHA256_SUMS
wget -N https://bitnion.org/bin/$RELEASE/$SHA256_SUMS_ASC

# Import the public key if not present
if ! gpg --list-keys "$SIGNER" >/dev/null 2>&1; then
    echo "🔑 Importing Bitnion public GPG key for signer: $SIGNER"
    gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys "$SIGNER"
fi

# Verify GPG signature
echo "🔍 Verifying GPG signature on SHA256SUMS file..."
gpg --verify $SHA256_SUMS_ASC $SHA256_SUMS

# Download binaries listed in SHA256SUMS
echo "📦 Downloading binaries listed in $SHA256_SUMS..."
grep "$RELEASE" $SHA256_SUMS | awk '{print $2}' | while read filename; do
    if [ ! -f "$filename" ]; then
        echo "⬇️  Fetching $filename..."
        wget -N https://bitnion.org/bin/$RELEASE/$filename
    else
        echo "✅ $filename already exists. Skipping download."
    fi
done

# Verify checksums
echo "🧮 Verifying SHA256 checksums..."
sha256sum -c $SHA256_SUMS

echo ""
echo "✅ All Bitnion binaries are verified and signed correctly."
echo "------------------------------------------------------------"
