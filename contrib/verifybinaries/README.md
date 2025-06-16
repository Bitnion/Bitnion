# Bitnion – Binary Verification Guide

This directory contains tools and instructions for verifying the integrity and authenticity of official Bitnion (BNO) release binaries.

---

## 🔐 Purpose

To ensure security and trust in every release, Bitnion Core developers provide:

- **SHA256 checksums** of all compiled binaries.
- **GPG-signed verification files** (`SHA256SUMS.asc`) to prove authenticity.
- A helper script (`verify.sh`) to automate the process of downloading, verifying, and auditing releases.

This process is based on best practices originally adopted by the Bitcoin Core project, adapted specifically for Bitnion.

---

## 📁 Files Included

- `verify.sh`  
  Bash script that downloads SHA256SUMS and its signature, imports the signer's GPG key (if missing), and verifies all files.

- `README.md`  
  This documentation file.

---

## 📦 File Layout (Per Release)

Each official Bitnion release will be available at:



https://bitnion.org/bin/vX.Y.Z/


And will include:

- `SHA256SUMS`
- `SHA256SUMS.asc`
- Signed binaries (e.g., `bitnion-x86_64-linux.tar.gz`, `bitnion-setup.exe`, etc.)

---

## ✅ How to Verify

1. Open a terminal and run:
   ```bash
   ./verify.sh v1.0.0 bitnion

Replace v1.0.0 with your desired release tag.

The script will:

Download SHA256SUMS and SHA256SUMS.asc

Fetch release binaries

Import the GPG key if not available

Verify signature and SHA256 checksums

If successful, you will see:

✅ All Bitnion binaries are verified and signed correctly.


🛡️ Security Notes
Always compare the GPG key fingerprint with Bitnion's official developer keys listed at:
https://bitnion.org/keys

Never trust unsigned or unofficial binaries.

Consider building from source if you have doubts about precompiled releases.

📧 Contact
For release announcements and key updates:

Website: https://bitnion.org

Email: bitnion@gmail.com

