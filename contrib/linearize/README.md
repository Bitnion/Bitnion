# Bitnion Blockchain Linearization Tools

This directory provides scripts used to **extract and linearize the Bitnion blockchain data** into a format suitable for explorers, archival systems, or deterministic backups.

These tools are adapted from Bitcoin Core and modified for full compatibility with Bitnion's blockchain structure and naming conventions.

---

## 📄 Files Included

| File Name               | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `example-linearize.cfg` | Configuration file for setting RPC and output parameters                    |
| `linearize-hashes.py`   | Collects and orders block hashes from the Bitnion node via RPC              |
| `linearize-data.py`     | Reads blocks from disk and writes them in linear format (`blk*.dat`)        |
| `README.md`             | This documentation                                                          |

---

## ⚙️ Prerequisites

- A running and fully synced `bitniond` node.
- RPC credentials (`rpcuser`, `rpcpassword`) configured in `bitnion.conf` or passed via config file.
- Python 3 installed in your system.

---

## 🧩 Workflow

1. **Configure:**
   Copy and edit `example-linearize.cfg`:
   ```bash
   cp example-linearize.cfg my-linearize.cfg
   nano my-linearize.cfg

