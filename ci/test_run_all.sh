#!/usr/bin/env bash
#
# Bitnion (BNO) – CI Pipeline Runner: Full Build and Test Suite
#
# This script sequentially executes all CI/testing phases for Bitnion Core.
# It ensures the Bitnion codebase (chainparams, pow.cpp, validation.cpp, etc.)
# is built, verified, and installed with full correctness and identity separation
# from Bitcoin Core.
#

set -euo pipefail
export LC_ALL=C

# Define Bitnion root
BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "${BITNION_ROOT_DIR}"

echo "🚀 Launching full Bitnion build + test pipeline..."

# Phase 1: Environment preparation
./ci/test/03_before_install.sh

# Phase 2: Pre-script environment setup
./ci/test/05_before_script.sh

# Phase 3: Choose your build configuration (e.g., native, Qt, TSan, Win64)
# Default: standard native build
./ci/test/00_setup_env.sh

# Phase 4: Build execution
./ci/test/06_script_a.sh

# Phase 5: Smoke testing
./ci/test/06_script_b.sh

# Phase 6: Installation
./ci/test/04_install.sh

# Optional: Post-validation tools (comment/uncomment as needed)
# ./ci/test/wrap-valgrind.sh ./src/bitniond --version
# ./ci/test/wrap-qemu.sh qemu-aarch64 ./src/bitniond --help
# ./ci/test/wrap-wine.sh ./src/bitniond.exe --version

echo "✅ Bitnion full CI pipeline completed successfully."
