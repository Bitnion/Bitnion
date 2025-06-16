#!/usr/bin/env bash
#
# detached-sig-apply.sh — Bitnion macOS Detached Signature Applier
#
# This script applies a previously generated detached digital signature
# to a signed .dmg file using macOS `codesign`.
#
# Adapted for Bitnion Core
# License: MIT

set -e

APP_NAME="Bitnion-Qt"
DMG_NAME="Bitnion-Core.dmg"
SIGNATURE_FILE="Bitnion-Core.dmg.signature"
SIGNED_DMG="Bitnion-Core-signed.dmg"
IDENTITY="Developer ID Application: Your Name (TEAMID)"  # Replace with actual code signing identity

echo "[*] Applying detached signature to $DMG_NAME..."

if [[ ! -f "$DMG_NAME" ]]; then
    echo "[!] Error: Unsigned DMG file '$DMG_NAME' not found."
    exit 1
fi

if [[ ! -f "$SIGNATURE_FILE" ]]; then
    echo "[!] Error: Detached signature '$SIGNATURE_FILE' not found."
    exit 1
fi

# Apply the signature using codesign
echo "[+] Signing with identity: $IDENTITY"
cp "$DMG_NAME" "$SIGNED_DMG"

codesign --sign "$IDENTITY" --timestamp --force "$SIGNED_DMG"

echo "[✓] Signature successfully applied."
echo "    Output: $SIGNED_DMG"
