#!/usr/bin/env python3
# Copyright (c) 2009-2025 The Bitnion Core Developers
# Distributed under the MIT software license

"""
Bitnion Core - Gitian Build Automation Script

This script automates reproducible builds using the Gitian build system.
It generates deterministic binary distributions for Linux, Windows, and macOS.

Usage:
  ./gitian-build.py --os linux,win,mac --sign --commit v1.0.0
"""

import os
import subprocess
import argparse
import sys

REPO_URL = "https://github.com/bitnion/bitnion.git"
RELEASES_DIR = os.path.expanduser("~/bitnion/gitian-build")
GITIAN_DIR = os.path.expanduser("~/gitian-builder")
SIGNER = os.getenv("SIGNER", "bitniondev")
DEFAULT_OS = ["linux", "win", "mac"]

def run(cmd, cwd=None):
    print(f"🛠️  Running: { .join(cmd)}")
    subprocess.check_call(cmd, cwd=cwd)

def parse_args():
    parser = argparse.ArgumentParser(description="Bitnion Gitian build wrapper")
    parser.add_argument("--os", default="linux,win,mac", help="Comma-separated target OSes")
    parser.add_argument("--sign", action="store_true", help="Sign binaries with GPG")
    parser.add_argument("--commit", required=True, help="Git commit or tag to build")
    parser.add_argument("--jobs", default="2", help="Number of make jobs")
    return parser.parse_args()

def setup():
    os.makedirs(RELEASES_DIR, exist_ok=True)
    os.makedirs(GITIAN_DIR, exist_ok=True)

def clone_and_checkout(commit):
    src_dir = os.path.join(RELEASES_DIR, "bitnion")
    if not os.path.exists(src_dir):
        run(["git", "clone", REPO_URL, src_dir])
    run(["git", "fetch"], cwd=src_dir)
    run(["git", "checkout", commit], cwd=src_dir)
    return src_dir

def build_gitian(os_list, sign, commit, jobs):
    descriptor_map = {
        "linux": "gitian-linux.yml",
        "win": "gitian-win.yml",
        "mac": "gitian-osx.yml"
    }

    src_dir = os.path.join(RELEASES_DIR, "bitnion")
    for target_os in os_list:
        descriptor = descriptor_map[target_os]
        if not os.path.exists(f"contrib/gitian-descriptors/{descriptor}"):
            print(f"❌ Missing descriptor for {target_os}: {descriptor}")
            continue

        cmd = [
            "./bin/gbuild",
            "-j", jobs,
            "-m", "5120",
            "--commit", f"bitnion={commit}",
            f"../bitnion/contrib/gitian-descriptors/{descriptor}"
        ]
        run(cmd, cwd=GITIAN_DIR)

        if sign:
            run([
                "./bin/gsign",
                "--signer", SIGNER,
                "--release", commit,
                "--destination", "signed",
                f"../bitnion/contrib/gitian-descriptors/{descriptor}"
            ], cwd=GITIAN_DIR)

        run(["mv", "build/out", f"{RELEASES_DIR}/{target_os}-{commit}"], cwd=GITIAN_DIR)

def main():
    args = parse_args()
    os_list = args.os.split(",")
    setup()
    clone_and_checkout(args.commit)
    build_gitian(os_list, args.sign, args.commit, args.jobs)

if __name__ == "__main__":
    main()

