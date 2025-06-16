#!/usr/bin/env bash
#
# extract-osx-sdk.sh — Bitnion macOS SDK Extractor
#
# This script extracts the macOS SDK from an Xcode installation or
# manually downloaded SDK .dmg or .tar.gz archive.
#
# It is intended to be used for cross-compiling Bitnion Core on Linux.
#
# License: MIT
# Adapted from Bitcoin Core's contrib/macdeploy/extract-osx-sdk.sh

set -e

SDK_ARCHIVE=""
SDK_DIR="MacOSX10.11.sdk"
TARGET_DIR="$(pwd)/sdk"

echo "[*] Bitnion SDK Extractor for macOS cross-compilation"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <path-to-Xcode-SDK-archive>"
    echo "Example: ./extract-osx-sdk.sh ~/Downloads/Xcode-SDKs/MacOSX10.11.sdk.tar.gz"
    exit 1
fi

SDK_ARCHIVE="$1"

if [[ ! -f "$SDK_ARCHIVE" ]]; then
    echo "[!] Error: File not found: $SDK_ARCHIVE"
    exit 1
fi

echo "[+] Extracting SDK archive: $SDK_ARCHIVE"
mkdir -p "$TARGET_DIR"

if [[ "$SDK_ARCHIVE" == *.tar.gz ]]; then
    tar -xzvf "$SDK_ARCHIVE" -C "$TARGET_DIR"
elif [[ "$SDK_ARCHIVE" == *.dmg ]]; then
    echo "[*] Mounting DMG..."
    MOUNT_DIR=$(hdiutil attach "$SDK_ARCHIVE" | grep Volumes | awk '{print $3}')
    if [[ -z "$MOUNT_DIR" ]]; then
        echo "[!] Failed to mount DMG."
        exit 1
    fi
    echo "[+] Copying SDK from DMG..."
    cp -a "$MOUNT_DIR/$SDK_DIR" "$TARGET_DIR/"
    hdiutil detach "$MOUNT_DIR"
else
    echo "[!] Unsupported SDK format: $SDK_ARCHIVE"
    exit 1
fi

echo "[✓] SDK extracted to: $TARGET_DIR/$SDK_DIR"
echo
echo "You can now use this SDK to cross-compile Bitnion Core with osxcross or depends."
