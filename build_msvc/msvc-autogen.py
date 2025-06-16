#!/usr/bin/env python3
import os
import shutil

# === Bitnion MSVC Autogen Script ===
# Autogenerate Visual Studio .vcxproj from .vcxproj.in templates
# Author: Bitnion Core Developers

SRC_DIR = os.path.dirname(os.path.realpath(__file__))
PROJECTS = [
    "bench_bitnion",
    "bitnion-cli",
    "bitniond",
    "bitnion-qt",
    "bitnion-wallet",
    "bitnion-tx",
    "libbitnion_wallet_tool"
]

def generate_vcxproj(project):
    in_path = os.path.join(SRC_DIR, project, f"{project}.vcxproj.in")
    out_path = os.path.join(SRC_DIR, project, f"{project}.vcxproj")

    if not os.path.isfile(in_path):
        print(f"[*] Skipping {project}: template not found.")
        return

    print(f"[+] Generating {project}.vcxproj")
    with open(in_path, "r", encoding="utf-8") as fin:
        content = fin.read()

    # Token replacement (if needed)
    content = content.replace("bitcoin", "bitnion")
    content = content.replace("BITCOIN", "BITNION")
    content = content.replace("Bitcoin", "Bitnion")

    with open(out_path, "w", encoding="utf-8") as fout:
        fout.write(content)

def main():
    print("=== Bitnion MSVC Autogen ===")
    for project in PROJECTS:
        project_dir = os.path.join(SRC_DIR, project)
        if not os.path.exists(project_dir):
            print(f"[!] Skipping {project}: directory does not exist.")
            continue
        generate_vcxproj(project)

    print("=== Autogen complete. You can now open bitnion.sln in Visual Studio ===")

if __name__ == "__main__":
    main()
