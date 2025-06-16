#!/usr/bin/env python3
# Copyright (c) 2009-2025 The Bitnion Core Developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or https://opensource.org/licenses/MIT

"""
This script checks or inserts the standard copyright header
in all Bitnion source files (.cpp, .h).
"""

import os
import re
import sys

LICENSE_HEADER = """\
// Copyright (c) 2009-2025 The Bitnion Core Developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or https://opensource.org/licenses/MIT
"""

ALLOWED_EXTENSIONS = [".cpp", ".h", ".hpp", ".c", ".cc"]

def has_header(content):
    return "The Bitnion Core Developers" in content

def check_file(path, autofix=False):
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    if has_header(content):
        return True

    if autofix:
        with open(path, "w", encoding="utf-8") as f:
            f.write(LICENSE_HEADER + "\n" + content)
        print(f"✔️  Header added: {path}")
        return True
    else:
        print(f"❌ Missing header: {path}")
        return False

def process_directory(root, autofix=False):
    failed = 0
    for dirpath, _, filenames in os.walk(root):
        for file in filenames:
            ext = os.path.splitext(file)[1]
            if ext in ALLOWED_EXTENSIONS:
                fullpath = os.path.join(dirpath, file)
                if not check_file(fullpath, autofix=autofix):
                    failed += 1
    return failed

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Bitnion copyright header checker")
    parser.add_argument("path", nargs="?", default=".", help="Path to check (default: current directory)")
    parser.add_argument("--fix", action="store_true", help="Automatically add missing headers")
    args = parser.parse_args()

    failures = process_directory(args.path, autofix=args.fix)

    if failures > 0:
        print(f"\n{failures} file(s) missing headers.")
        sys.exit(1)
    else:
        print("✅ All files have valid Bitnion headers.")

if __name__ == "__main__":
    main()

