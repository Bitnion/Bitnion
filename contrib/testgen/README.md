# Bitnion – Key and Address Test Generators

This directory contains test vector generators for verifying Bitnion's key and address encoding systems. These tools are designed to match the encoding logic used in `chainparams.cpp`, `pow.cpp`, `validation.cpp`, and other core components.

---

## 📄 Included Files

- `base58.py`  
  Contains pure Python implementations of Base58 encode/decode functions used by Bitnion for address formatting.

- `gen_key_io_test_vectors.py`  
  Generates reference test vectors (in JSON format) for validating Bitnion's public addresses and private key (WIF) encodings.

- `key_io_test_vectors.json`  
  Auto-generated file produced by the script above, useful for regression tests and format verification.

---

## 🧪 Purpose

These tools allow developers and testers to ensure:

- Bitnion addresses (`bno1...`) follow valid Base58Check encoding rules.
- Secret keys are properly encoded using Bitnion's prefix scheme (0x99).
- Public key hashes (prefix 0x19) are encoded consistently with expectations defined in `chainparams.cpp`.

---

## ⚙️ How to Use

1. Run:
   ```bash
   python3 base58.py


This validates that encode/decode operations match across conversions.

Then generate test vectors:
python3 gen_key_io_test_vectors.py


It will create a file: key_io_test_vectors.json.

You can use these vectors in your unit tests or to cross-verify against compiled C++ behavior.

Related Source Files
src/chainparams.cpp
Contains prefix values for public keys and private keys used in address generation.

src/pow.cpp
Affects mining logic and chain state; indirectly validated via address consistency in blocks.

src/validation.cpp
Performs full block and transaction validation, including proof-of-work and timestamp checks.

README.md
General overview of Bitnion's architecture, goals, and distribution policy.

🤝 Contribution
Pull requests that improve coverage or support new address types (e.g. Bech32 for Bitnion) are welcome. Scripts must remain deterministic and Python 3 compatible.

📧 Contact
For bug reports or improvements, email: bitnion@gmail.com

