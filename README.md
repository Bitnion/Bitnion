# 🌐 Bitnion (BNO)

**Bitnion** is a decentralized, Bitcoin-inspired cryptocurrency protocol with a hard-capped supply of **15 million BNO**, transparent crowdsale, and zero inflation.

Bitnion is scheduled to launch on **10 November 2025** with open-source governance and a fully transparent emission curve designed to end by the year 2130.

---

## 🔢 Token Summary

- **Token Name**: Bitnion
- **Ticker**: BNO
- **Max Supply**: 15,000,000 BNO (fixed)
- **Premine (Genesis Block)**: 1,000,000 BNO
  - 950,000 BNO allocated for public contributors
  - 50,000 BNO reserved for infrastructure and development
- **Mining Supply**: 14,000,000 BNO (via PoW)
- **Consensus**: Proof-of-Work (SHA256D)
- **Block Time**: 10 minutes
- **Halving Interval**: 210,000 blocks (~4 years)
- **Reward Starts At**: 33.333333 BNO per block
- **Mining Ends**: ~Year 2130

---

## 💸 Crowdsale Overview

- **Crowdsale Supply**: 950,000 BNO
- **Price**: 1 BTC = 2,000 BNO
- **Max BTC Accepted**: 475 BTC
- **BTC Contribution Address**:

bc1qudjqs32yc9ggae9e38pa36t4rymrgwdldu869k


### 📩 How to Contribute

1. Send BTC to the official address above.
2. Email **bitnion@gmail.com** with:
 - Your **Bitcoin sender address**
 - The **transaction ID (TXID)**
 - BTC amount and expected BNO
3. After launch, send your **Bitnion wallet address** to receive BNO.

> ⛓️ All allocations will be recorded on-chain and reflected in the genesis block.

---

## 💼 Use of Crowdsale Funds

BTC raised from the crowdsale will be used transparently and exclusively for:

- Domain and website infrastructure
- DNS seed node hosting
- Public explorer and chain tools

> Bitnion is a community-first project. No funds will be used for private gain or speculation.

---

## ⛏️ Emission Schedule

Bitnion uses a Bitcoin-style halving model with a tailored emission curve to reach 14 million mined BNO by ~2130.

| Era | Block Reward | Coins Mined     | Duration     |
|-----|---------------|------------------|--------------|
| 0   | 33.333333 BNO | 7,000,000 BNO    | 2025–2029    |
| 1   | 16.666666 BNO | 3,500,000 BNO    | 2029–2033    |
| 2   | 8.333333 BNO  | 1,750,000 BNO    | 2033–2037    |
| 3   | 4.166666 BNO  | 875,000 BNO      | 2037–2041    |
| ... | ...           | ...              | ...          |
| N   | ≈ 0 BNO       | → 14M total      | Until ~2130  |

---

## 📁 Project Structure

| File/Folder             | Description                                      |
|--------------------------|--------------------------------------------------|
| `src/chainparams.cpp`    | Network rules, reward logic, genesis block       |
| `src/validation.cpp`     | Consensus and block verification                 |
| `src/pow.cpp`            | Mining difficulty and proof-of-work              |
| `docs/tokenomics.md`     | Full emission schedule and supply breakdown      |
| `docs/premine_policy.md` | Details of the 1M BNO genesis allocation         |
| `docs/crowdsale_instructions.md` | Contribution process                    |
| `docs/crowdsale_log.md`  | Public log of verified contributions             |
| `DISCLAIMER.md`          | Legal and regulatory disclaimer                  |
| `COPYING`                | MIT License                                      |

---

## 🛡️ Legal Notice

Bitnion is not an investment vehicle. It provides no promise of future value or profit. Participation in the crowdsale is voluntary and subject to applicable local laws.

See [`DISCLAIMER.md`](./DISCLAIMER.md) for complete legal terms.

---

## 📦 License

Bitnion is released under the [MIT License](./COPYING). Contributions, forks, and independent deployments are welcome.

---

## 🚀 Launch Details

- **Genesis Block**: Includes 1,000,000 BNO premine
- **Crowdsale**: Closes when all 950,000 BNO are sold
- **Mining Begins**: From block #1, using SHA256D
- **Supply Cap**: 15,000,000 BNO forever

> Bitnion is built to last. Decentralized by design, fixed in supply, and free to audit by anyone.

