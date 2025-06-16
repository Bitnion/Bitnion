# Bitnion Network QoS Testing Tools

This directory provides utilities for testing **Quality of Service (QoS)** on the Bitnion P2P network. It is intended for developers, researchers, or maintainers who wish to analyze how the Bitnion node behaves under network stress, such as latency, bandwidth limits, or packet loss.

---

## 📦 Contents

| File   | Description                                                  |
|--------|--------------------------------------------------------------|
| `tc.sh` | Shell script to emulate traffic shaping using `tc`         |
| `README.md` | This documentation                                       |

---

## ⚙️ Requirements

- Linux system with `tc` (traffic control) installed
- Root permissions to modify network interfaces
- An active Bitnion node (`bitniond`) running locally

---

## 🧪 Example Usage

### Emulate 100ms Latency, 1Mbps Bandwidth, and 1% Packet Loss

```bash
sudo ./tc.sh eth0 100ms 1mbit 1%

