# 🔐 Bitnion Security Policy

Bitnion (BNO) is an open-source, Bitcoin-inspired cryptocurrency focused on transparency, decentralization, and long-term immutability. The following policy outlines the principles and practices used to protect the protocol and its participants.

---

## 🛡️ Key Security Principles

- **Immutable Supply**: The total supply is permanently capped at 15,000,000 BNO with no future minting or inflation.
- **Open Genesis**: All premine and crowdsale allocations are verifiably embedded in the genesis block.
- **Decentralized Mining**: No coins are premined beyond the genesis; mining starts at block #1 using SHA256D.
- **No Private Keys Custody**: Bitnion never stores or manages user keys. You control your wallet.
- **Auditable Code**: Full source code is open-source under MIT License (see `COPYING`).

---

## 🧾 Crowdsale Safety Guidelines

Bitnion uses a transparent, manual crowdsale process prior to mainnet launch:

1. Send BTC to the **public contribution address**:

bc1qudjqs32yc9ggae9e38pa36t4rymrgwdldu869k

2. Email `bitnion@gmail.com` with:
- Your sender BTC address
- Transaction ID (TXID)
- Expected BNO
3. After launch, email your **Bitnion wallet address** to receive BNO.

📌 All contributions are non-refundable and must follow the instructions in `docs/crowdsale_instructions.md`.

---

## ⚠️ Responsible Disclosure

If you discover a critical vulnerability in the Bitnion codebase (e.g. consensus bug, double-spend exploit, infinite inflation), **please report it privately** to:

**📧 bitnion@gmail.com**

You may optionally encrypt with a public PGP key (not yet published).

---

## 📂 Verifiable Files & Security Integrity

- `src/chainparams.cpp` — Network rules and genesis integrity
- `src/validation.cpp` — Reward and block consensus
- `src/pow.cpp` — Difficulty and PoW logic
- `docs/tokenomics.md` — Transparent fixed supply
- `docs/crowdsale_instructions.md` — Manual contribution process
- `DISLAIMER.md` — Legal limits and voluntary terms

All files are permanently part of the project and tracked at:
> [https://github.com/Bitnion/Bitnion](https://github.com/Bitnion/Bitnion)

---

## 🚫 What Bitnion Does Not Do

- ❌ No staking, airdrops, or inflation
- ❌ No custodial wallets or account creation
- ❌ No login or KYC
- ❌ No centralized control or override key

---

## ✅ Summary

| Topic                     | Status    |
|---------------------------|-----------|
| Public Auditability       | ✅ Yes     |
| Manual Contribution       | ✅ Verified via email |
| Decentralized Consensus   | ✅ SHA256D |
| Open Source Code          | ✅ MIT License |
| Inflation / Minting       | ❌ Never   |
| Bug Bounty Program        | 📧 Email-based |

---

*Bitnion is designed for public security, not speculation. Participate responsibly and review the source code before use.*

