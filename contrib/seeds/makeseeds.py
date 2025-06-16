#!/usr/bin/env python3
#
# makeseeds.py — Bitnion Hardcoded DNS Seed Generator
#
# Processes node IPs from collected data (e.g. nodes_main.txt) and outputs
# a list of validated IPv4 seed nodes formatted for inclusion in chainparams.cpp.
#
# License: MIT
# Adapted for Bitnion Core

import re
import sys
import ipaddress

SEED_INPUT_FILE = "nodes_main.txt"
SUSPICIOUS_FILE = "suspicious_hosts.txt"
OUTPUT_COUNT = 512

def parse_ip(line):
    m = re.match(r'^(\d{1,3}(?:\.\d{1,3}){3})', line)
    return m.group(1) if m else None

def load_ip_set(filename):
    ipset = set()
    with open(filename, 'r') as f:
        for line in f:
            ip = parse_ip(line.strip())
            if ip:
                try:
                    ipaddress.IPv4Address(ip)
                    ipset.add(ip)
                except ipaddress.AddressValueError:
                    continue
    return ipset

def ip_to_uint32(ip):
    parts = ip.split('.')
    return "0x{:02x}{:02x}{:02x}{:02x}".format(int(parts[0]), int(parts[1]), int(parts[2]), int(parts[3]))

def main():
    print(f"[*] Reading seed IPs from: {SEED_INPUT_FILE}")
    seed_ips = load_ip_set(SEED_INPUT_FILE)

    print(f"[*] Reading suspicious IPs from: {SUSPICIOUS_FILE}")
    bad_ips = load_ip_set(SUSPICIOUS_FILE)

    print(f"[*] Filtering out {len(bad_ips)} known suspicious IPs...")
    clean_ips = sorted(seed_ips - bad_ips)

    print(f"[✓] {len(clean_ips)} clean IPs available. Selecting up to {OUTPUT_COUNT} for embedding.\n")

    output_ips = clean_ips[:OUTPUT_COUNT]

    print("// Format for chainparams.cpp")
    print("static const uint32_t pnSeed[] = {")
    for ip in output_ips:
        print(f"    {ip_to_uint32(ip)}, // {ip}")
    print("};")

if __name__ == "__main__":
    main()
