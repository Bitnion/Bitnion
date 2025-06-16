# Bitnion Seed Nodes

This directory contains scripts and data files used for generating and maintaining DNS seed nodes for the Bitnion (BNO) network.

---

## 📁 Files in This Directory

- `generate-seeds.py`  
  Script to fetch, clean, and sort reachable nodes from known peer sources.

- `makeseeds.py`  
  Generates hardcoded seed list entries to be added into the `chainparams.cpp` source file.

- `nodes_main.txt`  
  Raw list of reachable mainnet nodes discovered from Bitnion peer-to-peer connections.

- `nodes_test.txt`  
  List of nodes collected from testnet environments.

- `suspicious_hosts.txt`  
  Optional list to manually exclude malicious or suspicious IPs during seed generation.

---

## 🔄 How to Use

1. **Gather Node Data**  
   Update `nodes_main.txt` and `nodes_test.txt` by crawling the network using your own crawler or trusted peers.

2. **Run Scripts**  
   Use:
   ```bash
   python3 generate-seeds.py
   python3 makeseeds.py

This will generate sanitized, deduplicated node entries for DNS seeding.

Update Source Code
Insert the generated seed entries into src/chainparams.cpp, like:
vSeeds.emplace_back("seed.bitnion.org");
Test Network Consistency
Make sure seed entries are live, properly ported (default 9333), and adhere to Bitnion’s consensus rules.

Related Source Files
src/chainparams.cpp
DNS seed entries (vSeeds) are defined here for the Bitnion main network.

src/pow.cpp
Defines block subsidy halving and Proof-of-Work constraints for BNO.

src/validation.cpp
Contains core block/transaction validation logic on the Bitnion network.

README.md
High-level overview of Bitnion’s mission, technical specs, and distribution model.
Disclaimer
This directory is part of the Bitnion (BNO) project and is not compatible with Bitcoin or any other fork. All naming conventions, scripts, and seed formats are tailored specifically for the Bitnion ecosystem.

For seed submissions or contributions, please contact: bitnion@gmail.com
