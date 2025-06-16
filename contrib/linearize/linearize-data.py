#!/usr/bin/env python3
#
# linearize-data.py — Bitnion Block Exporter (linear blk format)
#
# This script reads a list of block hashes (from linearize-hashes.py)
# and exports raw block files (blkNNNN.dat) in order, as used in explorers.
#
# Adapted from Bitcoin Core. Modified for Bitnion Core.
# License: MIT
# ----------------------------------------------------------------------

import os
import struct
import sys
import configparser

MAGIC_DEFAULT = b'\xb1\xf3\xc4\xa1'  # Bitnion mainnet magic bytes

def read_config(filename):
    cfg = {}
    parser = configparser.ConfigParser()
    parser.read(filename)
    for section in parser.sections():
        for key, val in parser.items(section):
            cfg[key] = val
    return cfg

def hex_to_bytes(hexstr):
    return bytes.fromhex(hexstr)

def read_block_file(datadir, blkhash):
    blkfile_path = os.path.join(datadir, "blocks", "index")
    for root, dirs, files in os.walk(os.path.join(datadir, "blocks")):
        for fname in files:
            fpath = os.path.join(root, fname)
            if not fname.startswith("blk"):
                continue
            with open(fpath, "rb") as f:
                data = f.read()
                pos = data.find(hex_to_bytes(blkhash)[::-1])  # reverse for LE
                if pos != -1:
                    # Seek to start of block magic
                    return extract_block(fpath, pos)
    return None

def extract_block(fpath, pos):
    with open(fpath, "rb") as f:
        f.seek(pos - 8)  # magic (4) + length (4)
        header = f.read(8)
        if len(header) < 8:
            return None
        magic, length = struct.unpack("<4sI", header)
        block = f.read(length)
        return magic + struct.pack("<I", length) + block

def write_blocks(hashes, datadir, out_dir, prefix, split_size, netmagic):
    out_count = 0
    out_bytes = 0
    file_index = 0
    out_file = None

    os.makedirs(out_dir, exist_ok=True)

    for h in hashes:
        block = read_block_file(datadir, h)
        if not block:
            print(f"[!] Warning: Block {h} not found in data dir")
            continue

        if out_file is None or (split_size and out_bytes > split_size):
            if out_file:
                out_file.close()
            filename = os.path.join(out_dir, f"{prefix}{file_index:05d}.dat")
            out_file = open(filename, "wb")
            print(f"[+] Writing to {filename}")
            file_index += 1
            out_bytes = 0

        out_file.write(block)
        out_bytes += len(block)

    if out_file:
        out_file.close()
        print(f"[✓] Export complete. {file_index} file(s) written.")

def main():
    if len(sys.argv) < 2:
        print("Usage: linearize-data.py <config-file>")
        sys.exit(1)

    config_path = sys.argv[1]
    cfg = read_config(config_path)

    datadir = cfg.get("datadir", os.path.expanduser("~/.bitnion"))
    output_dir = cfg.get("output_dir", "./output")
    hashlist_file = cfg.get("hashlist_file", "hashes.txt")
    prefix = cfg.get("file_prefix", "blk")
    split_size_mb = int(cfg.get("split_size_mb", "0"))
    netmagic_hex = cfg.get("netmagic", "b1f3c4a1")

    split_size = split_size_mb * 1024 * 1024
    netmagic = hex_to_bytes(netmagic_hex)

    print("[*] Reading block hashes...")
    with open(hashlist_file, "r") as f:
        hashes = [line.strip() for line in f if line.strip()]

    print(f"[*] Exporting {len(hashes)} blocks to: {output_dir}")
    write_blocks(hashes, datadir, output_dir, prefix, split_size, netmagic)

if __name__ == "__main__":
    main()
