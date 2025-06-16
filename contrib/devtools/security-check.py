#!/usr/bin/env python3
# Copyright (c) 2009-2025 The Bitnion Core Developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or https://opensource.org/licenses/MIT

"""
Bitnion Core - Static Security Check Script

This script scans C++ source files in the Bitnion codebase for usage
of potentially dangerous or banned functions.

These checks help ensure the long-term security and integrity of the Bitnion project.
"""

import os
import re
import sys

# Dangerous functions to flag
DANGEROUS_FUNCTIONS = [
    "strcpy",
    "strcat",
    "sprintf",
    "vsprintf",
    "gets",
    "scanf",
    "sscanf",
    "fscanf",
    "atoi",
    "atol",
    "atoll"
]

# Allowed file extensions for source files
SOURCE_EXTENSIONS = [".cpp", ".c", ".h", ".hpp", ".cc"]

def is_source_file(filename):
    return any(filename.endswith(ext) for ext in SOURCE_EXTENSIONS)

def check_file(filepath):
    issues = []
    try:
        with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
            for lineno, line in enumerate(f, 1):
                for func in DANGEROUS_FUNCTIONS:
                    if re.search(r"\\b" + func + r"\\s*\\(", line):
                        issues.append((lineno, func, line.strip()))
    except Exception as e:
        print(f"⚠️ Failed to read file {filepath}: {e}")
    return issues

def scan_directory(path):
    findings = []
    for root, _, files in os.walk(path):
        for file in files:
            if is_source_file(file):
                fullpath = os.path.join(root, file)
                result = check_file(fullpath)
                if result:
                    findings.append((fullpath, result))
    return findings

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Bitnion security pattern checker")
    parser.add_argument("path", nargs="?", default=".", help="Directory to scan (default: current)")
    args = parser.parse_args()

    results = scan_directory(args.path)
    if not results:
        print("✅ No dangerous function usage detected.")
        sys.exit(0)

    print("🚨 Potential security issues found:\n")
    for filepath, issues in results:
        print(f"File: {filepath}")
        for lineno, func, line in issues:
            print(f"  Line {lineno}: {func} → {line}")
        print("-" * 60)

    sys.exit(1)

if __name__ == "__main__":
    main()

