#!/usr/bin/env python3
#
# Bitnion DNS Seeder IP Extractor
#
# This script resolves DNS seed hostnames and generates a list
# of IP addresses (IPv4) suitable for embedding as hardcoded seeds
# in chainparams.cpp.
#
# License: MIT
# Adapted from Bitcoin Core's generate-seeds.py

import sys
import socket
import dns.resolver
import ipaddress

SEEDS = [
    "seed.bitnion.org",
    "dnsseed.bitnion.network",
    "seed1.bitnion.dev",
    "seed2.bitnion.foundation"
]

def resolve_seed(hostname):
    print(f"Resolving: {hostname}")
    try:
        result = dns.resolver.resolve(hostname, 'A')
        return [str(ip.address) for ip in result]
    except Exception as e:
        print(f"  [!] Error resolving {hostname}: {e}")
        return []

def main():
    all_ips = set()
    for seed in SEEDS:
        ips = resolve_seed(seed)
        all_ips.update(ips)

    # Filter and print IPs in C++ initializer format
    valid_ips = []
    for ip in sorted(all_ips):
        try:
            obj = ipaddress.ip_address(ip)
            if isinstance(obj, ipaddress.IPv4Address):
                formatted = f'0x{obj.reverse_pointer.split(".")[3]:0>2x}{obj.reverse_pointer.split(".")[2]:0>2x}{obj.reverse_pointer.split(".")[1]:0>2x}{obj.reverse_pointer.split(".")[0]:0>2x}'
                valid_ips.append(f"0x{obj.packed.hex()},")
        except Exception as e:
            print(f"  Skipping invalid IP {ip}: {e}")
            continue

    print("\n// Format for chainparams.cpp — hardcoded seed IPs")
    print("static const uint32_t pnSeed[] = {")
    for line in valid_ips:
        print(f"    {line}")
    print("};")

if __name__ == "__main__":
    main()
