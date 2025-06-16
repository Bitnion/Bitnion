# Bitnion macOS Deployment

This directory contains tools and resources used to package **Bitnion Core** for macOS distribution, including creation of a signed `.dmg` installer with a custom background and layout.

All components in this directory have been adapted from open-source templates and customized for the Bitnion project.

---

## 📂 Contents

| File                           | Description                                                               |
|--------------------------------|---------------------------------------------------------------------------|
| `background.svg`              | SVG background design for the `.dmg` installer window                     |
| `background.png`              | PNG background used by macOS Finder in the mounted volume                |
| `custom_dsstore.py`           | Script to generate `.DS_Store` layout metadata for icon positioning      |
| `detached-sig-create.sh`      | Generates a detached GPG signature for the `.dmg` file                   |
| `detached-sig-apply.sh`       | Applies Apple Developer ID signature to the `.dmg` (via codesign)        |
| `extract-osx-sdk.sh`          | Extracts macOS SDK for cross-compiling Bitnion Core on Linux             |
| `fancy.plist`                 | Optional layout metadata for Finder window configuration                 |
| `gen-sdk`                     | Helper script to copy extracted SDK to the expected location             |
| `macdeployqtplus`             | Orchestrates deployment using `macdeployqt`, layout setup, and `.dmg` creation |
| `LICENSE`                     | MIT license covering all files in this directory                         |
| `README.md`                   | This documentation file                                                  |

---

## 🛠️ Build Requirements

- macOS with Xcode CLI tools
- Qt 5 (e.g., from Homebrew: `brew install qt@5`)
- A built `Bitnion-Qt.app` bundle in the current working directory
- macOS SDK 10.11 or later (optional for Linux cross-compilation)

---

## 🔧 DMG Creation Workflow

### 1. Ensure Application is Built

Ensure you have compiled Bitnion Core and created the `.app` bundle:

