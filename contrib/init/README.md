# Bitnion Init System Integration

This directory contains service scripts and configuration files for running the **Bitnion Core daemon (`bitniond`)** under various init systems across Linux and macOS.

Each script allows `bitniond` to run as a background service that starts at boot, manages its own logs, and shuts down gracefully.

---

## 📂 Contents

| File Name                        | Description                                                      |
|----------------------------------|------------------------------------------------------------------|
| `bitniond.conf`                  | Example configuration file for `bitniond`                        |
| `bitniond.service`               | Systemd unit for most modern Linux distributions                 |
| `bitniond.init`                 | SysV init script for Debian/Devuan/older Linux systems           |
| `bitniond.openrc`               | OpenRC script for Alpine, Gentoo, Artix, etc.                    |
| `bitniond.openrcconf`           | Optional config file for OpenRC (if parameters need separation)  |
| `org.bitnion.bitniond.plist`    | macOS `launchd` service file for automatic start at login        |
| `README.md`                     | This documentation                                               |

---

## 🖥️ System Support

| Init System | OS / Distro Example     | Script File                      |
|-------------|--------------------------|----------------------------------|
| systemd     | Ubuntu, Arch, Fedora     | `bitniond.service`               |
| SysVinit    | Debian (legacy), Devuan  | `bitniond.init`                  |
| OpenRC      | Alpine, Gentoo, Artix    | `bitniond.openrc`, `*.openrcconf`|
| launchd     | macOS                    | `org.bitnion.bitniond.plist`     |

---

## ⚙️ Installation Instructions

### 🔹 systemd (Linux)

```bash
sudo cp bitniond.service /etc/systemd/system/
sudo systemctl daemon-reexec
sudo systemctl enable bitniond
sudo systemctl start bitniond

