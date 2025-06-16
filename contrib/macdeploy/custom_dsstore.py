#!/usr/bin/env python3
#
# custom_dsstore.py — Bitnion macOS DMG layout generator
#
# This script creates a custom .DS_Store file used to control the visual layout
# of the Bitnion installer window on macOS.
#
# Adapted from Bitcoin Core's macdeployqt tools.
# License: MIT

import os
import struct
import subprocess

DS_STORE_CREATOR_TOOL = "/usr/local/bin/dsstore"

def create_dsstore(volume_path, background_file="background.png"):
    if not os.path.exists(DS_STORE_CREATOR_TOOL):
        raise FileNotFoundError("Required tool 'dsstore' not found at: " + DS_STORE_CREATOR_TOOL)

    print(f"[+] Generating .DS_Store for Bitnion DMG at: {volume_path}")

    # Configuration of layout: positions are in pixels
    icon_positions = {
        "Bitnion-Qt.app": (120, 150),
        "Applications": (380, 150)
    }

    # Set background image
    background_path = os.path.join(volume_path, background_file)
    if not os.path.exists(background_path):
        print(f"[!] Warning: Background file not found: {background_path}")
    else:
        subprocess.run([
            DS_STORE_CREATOR_TOOL,
            "--volume", volume_path,
            "--background", background_file,
            "--icon", "Bitnion-Qt.app", "120", "150",
            "--icon", "Applications", "380", "150",
            "--window-size", "600", "400"
        ], check=True)

    print("[✓] .DS_Store creation completed.")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Bitnion .DS_Store layout creator")
    parser.add_argument("volume", help="Path to mounted DMG volume")
    parser.add_argument("--background", default="background.png", help="Background image file")

    args = parser.parse_args()
    create_dsstore(args.volume, args.background)
