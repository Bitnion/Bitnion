# Security Policy

**Project:** Bitnion (BNO)  
**Contact:** [bitnion@gmail.com](mailto:bitnion@gmail.com)  
**License:** MIT  
**Codebase:** Bitcoin Core v26 fork

---

## 🔐 Supported Versions

Bitnion only supports the **latest stable release**. Prior versions are considered deprecated and may not receive patches or security fixes.

| Version       | Status     |
|---------------|------------|
| Latest Stable | ✅ Supported |
| Older Releases| ❌ Unsupported |

---

## 🛡️ Security Philosophy

Bitnion prioritizes transparency, immutability, and community verifiability.

- ✅ No dev tax  
- ✅ No minting or hidden inflation  
- ✅ No remote backdoors or control  
- ✅ Premine is hardcoded, public, and locked in genesis

Consensus code is deterministic and open for audit by anyone.

---

## 📬 Reporting Vulnerabilities

To report a security issue, please **do not disclose publicly**. Instead:

1. Email: [bitnion@gmail.com](mailto:bitnion@gmail.com)
2. Include:
   - Detailed description of the issue
   - Steps to reproduce (if applicable)
   - Suggested fix or mitigation (optional)
   - Your GPG key or contact info

We aim to respond within **72 hours**.

---

## 🔏 Consensus Rule Integrity

Bitnion forks Bitcoin Core v26 and inherits its mature validation stack. All consensus-affecting code must:

- Be deterministic and testable
- Undergo peer review via GitHub
- Be fully reproducible across nodes
- Avoid breaking compatibility without community consensus

---

## 🔎 Public Auditability

Bitnion commits to public audit and reproducibility:

- The genesis block is verifiable from source
- The premine UTXO is locked and can be traced
- All parameters are declared in `chainparams.cpp` and cannot be changed via RPC or wallet

---

## ❗ Disclaimer

Bitnion is open-source and distributed **as-is**, without any guarantees. Use is entirely at your own risk. Contributors and maintainers are not liable for any loss, misuse, or damages caused by bugs or protocol changes.

---

## 🔗 References

- [README.md](./README.md)
- [whitepaper.md](./whitepaper.md)
- [docs/premine_policy.md](./docs/premine_policy.md)
- [LICENSE](./LICENSE)

Thank you for supporting a secure and transparent cryptocurrency.

