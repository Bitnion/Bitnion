#!/usr/bin/env python3
# Copyright (c) 2006-2025 The Bitnion Core Developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or https://opensource.org/licenses/MIT

"""
Run clang-format on changed lines in Bitnion source files using diff input.
"""

import os
import re
import sys
import subprocess

CLANG_FORMAT_BINARY = os.environ.get("CLANG_FORMAT", "clang-format")
CLANG_FORMAT_STYLE = os.environ.get("CLANG_FORMAT_STYLE", "file")

def run_clang_format_diff(diff):
    lines_by_file = {}
    current_file = None

    for line in diff:
        if line.startswith("+++ b/"):
            current_file = line[6:].strip()
        elif line.startswith("@@") and current_file:
            m = re.match(r"@@ -\d+(?:,\d+)? \+(\d+)(?:,(\d+))? @@", line)
            if not m:
                continue
            start_line = int(m.group(1))
            line_count = int(m.group(2)) if m.group(2) else 1
            lines_by_file.setdefault(current_file, []).append((start_line, line_count))

    for filename, line_ranges in lines_by_file.items():
        if not os.path.exists(filename):
            continue
        with open(filename, "r", encoding="utf-8") as f:
            file_lines = f.readlines()

        formatted_lines = file_lines[:]
        for start, count in line_ranges:
            end = start + count - 1
            region = "".join(file_lines[start - 1:end])
            try:
                result = subprocess.run(
                    [CLANG_FORMAT_BINARY, f"--style={CLANG_FORMAT_STYLE}"],
                    input=region.encode("utf-8"),
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    check=True,
                )
                formatted_region = result.stdout.decode("utf-8").splitlines(True)
                formatted_lines[start - 1:end] = formatted_region
            except subprocess.CalledProcessError as e:
                print(f"Error formatting {filename}: {e.stderr.decode(utf-8)}", file=sys.stderr)
                continue

        with open(filename, "w", encoding="utf-8") as f:
            f.writelines(formatted_lines)

def main():
    if len(sys.argv) == 1:
        diff_input = sys.stdin.readlines()
    else:
        with open(sys.argv[1], "r", encoding="utf-8") as f:
            diff_input = f.readlines()

    run_clang_format_diff(diff_input)

if __name__ == "__main__":
    main()

