# Bitnion Guix Build System

This directory contains the deterministic build setup for **Bitnion** using the [GNU Guix](https://guix.gnu.org) functional package manager.

## 🛠 What Is This?

The Guix build system allows Bitnion contributors to perform reproducible builds across multiple target platforms. It eliminates dependency variance and ensures that builds are verifiable byte-for-byte.

## 📦 Files

- `guix-build.sh`: Entry point script. Run this to initiate builds.
- `manifest.scm`: Declares the full dependency manifest for Guix environment.
- `libexec/build.sh`: Invoked internally; handles autogen/configure/make.
- `README.md`: You are reading it.

## ✅ Prerequisites

- Guix installed and available in your `$PATH`
- Clone Bitnion source tree
- Working internet connection for package resolution

## 🚀 Usage

```bash
./contrib/guix/guix-build.sh x86_64-linux-gnu

