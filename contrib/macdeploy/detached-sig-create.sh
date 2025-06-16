#!/usr/bin/env bash
#
# detached-sig-create.sh — Bitnion DMG Detached Signature Generator
#
# This script creates a detached GPG signature for the final Bitnion
# macOS .dmg installer. The signature file can be published alongside
# the binary for independent verification.
#
# License: MIT
# Adapted for Bitnion Core

set -e

DMG_NAME="Bitnion-Core.dmg"
SIGNATURE_FILE="Bitnion-Core.dmg.signature"
GPG_KEY_ID="your-gpg-key-id"  # Replace with your actual GPG key ID

echo "[*] Generating detached signature for: $DMG_NAME"

if [[ ! -f "$DMG_NAME" ]]; then
    echo "[!] Error: File '$DMG_NAME' not found. Cannot sign."
    exit 1
fi

# Create a detached signature using GPG
gpg --output "$SIGNATURE_FILE" --detach-sig --armor --local-user "$GPG_KEY_ID" "$DMG_NAME"

echo "[✓] Detached signature created:"
echo "    -> $SIGNATURE_FILE"
echo
echo "To verify:"
echo "    gpg --verify $SIGNATURE_FILE $DMG_NAME"
