#!/usr/bin/env python3
# Bitnion (BNO) – Key I/O Test Vector Generator
#
# This script generates key and address encoding test vectors
# for Base58-compatible input/output tests in the Bitnion ecosystem.

import json
import hashlib

# Base58 alphabet (Bitcoin/Bitnion compatible)
alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

def sha256(data):
    return hashlib.sha256(data).digest()

def double_sha256(data):
    return sha256(sha256(data))

def base58_encode(b):
    """Encode bytes to a Base58 string."""
    count = 0
    for c in b:
        if c == 0:
            count += 1
        else:
            break
    num = int.from_bytes(b, 'big')
    result = ''
    while num > 0:
        num, mod = divmod(num, 58)
        result = alphabet[mod] + result
    return '1' * count + result

def base58check_encode(prefix, payload):
    """Encode data using Base58Check with a given prefix byte."""
    data = bytes([prefix]) + payload
    checksum = double_sha256(data)[:4]
    return base58_encode(data + checksum)

def generate_vectors():
    vectors = []

    # Example 1: Public key hash (P2PKH) address
    # Bitnion prefix = 0x19 (25) → starts with 'B'
    pubkey_hash = bytes.fromhex('1daa7fbbd3fa7a4f71e9a53d2dcd2e5e3e29ec7a')
    address = base58check_encode(0x19, pubkey_hash)
    vectors.append({
        "type": "pubkey_address",
        "prefix": "0x19",
        "hex": pubkey_hash.hex(),
        "base58": address
    })

    # Example 2: Secret key (private key)
    # Bitnion prefix = 0x99 (153)
    secret_key = bytes.fromhex('c3b1a1e4e6789cbf76f83a0f2e00fafeafb234ef4a22b4935e1b92eb88d0c2a3')
    wif = base58check_encode(0x99, secret_key)
    vectors.append({
        "type": "secret_key",
        "prefix": "0x99",
        "hex": secret_key.hex(),
        "base58": wif
    })

    return vectors

if __name__ == '__main__':
    vectors = generate_vectors()
    with open('key_io_test_vectors.json', 'w') as f:
        json.dump(vectors, f, indent=2)
    print("✅ Bitnion key I/O test vectors generated: key_io_test_vectors.json")
