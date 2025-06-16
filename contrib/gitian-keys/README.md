# Bitnion Gitian Signing Keys

This directory contains the list of **GPG key fingerprints** for all developers and contributors authorized to sign official Gitian builds of Bitnion.

## 📜 Purpose

Gitian builds are deterministic and verifiable. Each contributor runs the same build process and signs the resulting binaries. The signatures are collected and published to ensure the authenticity and reproducibility of every Bitnion release.

## 📂 File Structure

- `keys.txt`:  
  A flat list of all authorized GPG key fingerprints. Used during `gverify` and `gsign` to validate signatures.

- `*.asc`:  
  (Optional) Public key exports in ASCII-armored format for distribution.

## ➕ Adding Your Key

If you are a trusted Bitnion contributor or builder, you may add your GPG key to `keys.txt` via pull request. Ensure:

1. Your fingerprint is 40 hex characters (GPG SHA1).
2. Your key is signed and published to a keyserver or attached as `.asc`.
3. You include your name and optionally your email for traceability.

Example entry in `keys.txt`:

1234567890ABCDEF1234567890ABCDEF12345678  Your Name <you@example.org>

## 🛡️ Security Notes

- Do not accept unsigned builds.
- Verify signer keys match those in this repository.
- If any key is compromised, submit an immediate revocation notice.

## 🧩 Integration

Gitian build tools such as `gverify`, `gsign`, and `gbuild` will use this list during:
- Linux builds (`gitian-linux.yml`)
- Windows builds (`gitian-win.yml`)
- macOS builds (`gitian-osx.yml`)
- Corresponding signers: `gitian-win-signer.yml`, `gitian-osx-signer.yml`, etc.

---

© 2025 Bitnion Core. All rights reserved under the MIT License.
