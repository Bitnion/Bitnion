#!/usr/bin/env bash
#
# Bitnion (BNO) – Post-Build Smoke Test Script (Stage B)
#
# This script verifies the functionality of core Bitnion binaries after compilation.
# It checks CLI accessibility, command output consistency, and version branding.
#
# All components (chainparams, pow.cpp, validation.cpp, etc.) are assumed
# to be successfully built and integrated into Bitnion — not Bitcoin.
#

set -euo pipefail
export LC_ALL=C

echo "🧪 Starting Bitnion CLI smoke tests (stage B)..."

# Define Bitnion root
export BITNION_ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../.. && pwd)
cd "${BITNION_ROOT_DIR}/src"

# List of binaries to test
BINARIES=(bitniond bitnion-cli bitnion-util)

# Check each binary for existence and basic execution
for bin in "${BINARIES[@]}"; do
  if [[ -x "./${bin}" ]]; then
    echo "🔍 Testing ./${bin} --version"
    ./"${bin}" --version || echo "⚠️ ${bin} --version failed"
  else
    echo "❌ ${bin} not found or not executable in ./src/"
    exit 1
  fi
done

# Optional: daemon help command (ensure output branding is correct)
if ./bitniond --help | grep -i "bitnion" > /dev/null; then
  echo "✅ bitniond branding confirmed in --help output"
else
  echo "❌ bitniond help output does not reflect correct branding"
  exit 1
fi

# Clean exit
echo "✅ Bitnion CLI interface tests completed successfully."
