#!/usr/bin/env bash
# Bitnion (BNO) – GPG Signature Helper
#
# This script verifies GPG signatures on commits and tags in the Bitnion source tree.
# It checks whether commits are signed by a trusted developer key listed in
# contrib/verify-commits/trusted-keys

set -e

TRUSTED_KEYS_FILE="contrib/verify-commits/trusted-keys"
GPG_FLAGS="--status-fd=1 --no-default-keyring --keyring ./bitnion.gpg"

# Import trusted keys
echo "🔐 Importing trusted Bitnion developer keys..."
while read -r key; do
  if [[ "$key" =~ ^#.*$ || -z "$key" ]]; then
    continue
  fi
  gpg --no-default-keyring --keyring ./bitnion.gpg --recv-keys "$key"
done < "$TRUSTED_KEYS_FILE"

# Verify tag or commit
if [ -z "$1" ]; then
  echo "❌ Usage: $0 <commit-or-tag>"
  exit 1
fi

echo "🧾 Verifying GPG signature for: $1"
gpg $GPG_FLAGS --verify <(git show --show-signature "$1") || {
  echo "❌ Signature verification failed."
  exit 1
}

echo "✅ Signature verified successfully for $1"
