#!/usr/bin/env python3
# Copyright (c) 2009-2025 The Bitnion Core Developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or https://opensource.org/licenses/MIT

"""
Bitnion Core - Symbol Check Script

This script verifies that the final linked binaries do not contain unexpected
or forbidden symbols. This helps ensure deterministic builds and binary cleanliness.
"""

import os
import sys
import subprocess

ALLOWED_LIBRARIES = [
    "libc.so.6",
    "libpthread.so.0",
    "libm.so.6",
    "libstdc++.so.6",
    "libgcc_s.so.1",
    "linux-vdso.so.1",
    "ld-linux-x86-64.so.2"
]

ALLOWED_SYMBOL_PREFIXES = [
    "_ZN",  # C++ symbols (namespaces, classes)
    "__gmon_", "__libc_", "__cxa_", "_ITM_", "_Unwind_"
]

FORBIDDEN_SYMBOLS = [
    "malloc", "calloc", "realloc", "free", "printf", "fprintf", "sprintf", "snprintf"
]

def run_command(command):
    try:
        return subprocess.check_output(command, stderr=subprocess.STDOUT, text=True)
    except subprocess.CalledProcessError as e:
        print(f"❌ Command failed: {e.output}")
        sys.exit(1)

def check_binary(binary_path):
    print(f"🔍 Checking binary: {binary_path}")

    # Step 1: check undefined symbols
    output = run_command(["nm", "-D", "--defined-only", binary_path])
    for line in output.splitlines():
        if not line:
            continue
        parts = line.strip().split()
        if len(parts) < 3:
            continue
        symbol = parts[2]
        if any(symbol.startswith(pfx) for pfx in ALLOWED_SYMBOL_PREFIXES):
            continue
        if symbol in FORBIDDEN_SYMBOLS:
            print(f"🚫 Forbidden symbol found in {binary_path}: {symbol}")
            return False

    # Step 2: check dynamic libraries
    needed_libs = run_command(["ldd", binary_path])
    for line in needed_libs.splitlines():
        if "=>" not in line:
            continue
        lib = line.split("=>")[0].strip()
        if lib not in ALLOWED_LIBRARIES:
            print(f"⚠️  Unexpected library in {binary_path}: {lib}")
            return False

    print(f"✅ OK: {binary_path}")
    return True

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Bitnion Core binary symbol checker")
    parser.add_argument("binaries", metavar="binary", nargs="+", help="Paths to binary files")
    args = parser.parse_args()

    all_ok = True
    for binary in args.binaries:
        if not os.path.isfile(binary):
            print(f"⚠️  Skipping non-existent file: {binary}")
            continue
        if not check_binary(binary):
            all_ok = False

    if not all_ok:
        print("❌ Symbol check failed.")
        sys.exit(1)
    else:
        print("✅ All binaries passed symbol check.")

if __name__ == "__main__":
    main()

