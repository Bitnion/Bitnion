# Bitnion Core — contrib/

This directory contains various community-contributed tools, configuration files, test scripts, and utilities that support the Bitnion Core development, testing, packaging, and deployment process.

While the files here are not part of the core consensus or validation logic, they are essential for building a robust developer and deployment ecosystem.

---

## 📂 Directory Overview

| Directory               | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| `devtools/`             | Developer tools, Git hooks, sanity checks, Gitian/Guix signer setups       |
| `guix/`                 | Guix-based deterministic build environment setup                           |
| `macdeploy/`            | Tools for creating `.dmg` macOS installers with custom layout and branding |
| `gitian-descriptors/`   | Gitian build descriptors for deterministic binary builds                    |
| `gitian-keys/`          | GPG public keys for Gitian and release signer verification                  |
| `init/`                 | Init system integration files (systemd, launchd, openrc, sysvinit)          |
| `linearize/`            | Scripts for linearizing the blockchain for explorer or archival use         |
| `qos/`                  | Quality-of-Service testing tools using `tc` network emulation               |
| `verify-commits/`       | Scripts to verify signed commits for secure contribution review             |
| `install_db4.sh`        | Script to build Berkeley DB 4.8 locally for wallet compatibility            |

---

## 🛠️ Integration Notes

Many of these files support or directly link to core components of Bitnion Core such as:

- `chainparams.cpp`: Network definitions used in init scripts and builders
- `pow.cpp`: Proof-of-Work tuning used in testnet and regression networks
- `validation.cpp`: Core consensus logic exercised via QoS tools
- `README.md`: Top-level documentation references for maintainers

---

## 👥 Contribution Policy

The files here are maintained on a best-effort basis by contributors. If you create new init files, system scripts, or build tools for Bitnion, you are welcome to submit a pull request or patch under the terms of the MIT license.

All scripts must:
- Be reproducible and deterministic where applicable
- Avoid hardcoded environments or assumptions
- Use professional language, cross-platform paths, and licensing headers

---

## 📜 License

Unless otherwise noted, all contents in this directory are released under the MIT License. See `LICENSE` files in subdirectories for details.

---

© 2025 Bitnion Core Developers — All rights reserved.
