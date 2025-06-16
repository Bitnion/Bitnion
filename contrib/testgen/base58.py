#!/usr/bin/env python3
# Bitnion (BNO) – Base58 Encoding Utilities
#
# This script implements base58 encoding and decoding functions
# compatible with the Bitnion address and key formats, following
# the original Bitcoin Core implementation structure.

alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

def encode_base58(b):
    """Encode bytes into a base58-encoded string."""
    count = 0
    for byte in b:
        if byte == 0:
            count += 1
        else:
            break
    num = int.from_bytes(b, 'big')
    result = ''
    while num > 0:
        num, mod = divmod(num, 58)
        result = alphabet[mod] + result
    return '1' * count + result

def decode_base58(s):
    """Decode a base58-encoded string into bytes."""
    num = 0
    for char in s:
        num *= 58
        if char not in alphabet:
            raise ValueError(f"Invalid Base58 character: {char}")
        num += alphabet.index(char)
    combined = num.to_bytes((num.bit_length() + 7) // 8, 'big')
    # Add leading zero bytes
    n_pad = len(s) - len(s.lstrip('1'))
    return b'\x00' * n_pad + combined

if __name__ == '__main__':
    # Test vector for Bitnion
    example_bytes = b'\x00\xca\xfe\xba\xbe'
    encoded = encode_base58(example_bytes)
    decoded = decode_base58(encoded)
    print(f"Original Bytes  : {example_bytes.hex()}")
    print(f"Base58 Encoded  : {encoded}")
    print(f"Base58 Decoded  : {decoded.hex()}")
    assert decoded == example_bytes
    print("✅ Base58 encode/decode works as expected for Bitnion.")
