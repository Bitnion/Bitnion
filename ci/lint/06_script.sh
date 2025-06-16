#!/usr/bin/env bash
set -euo pipefail

echo ">> Running Bitnion lint script..."

# === Lint: Shell Scripts ===
find . -type f -name "*.sh" ! -path "./depends/*" ! -path "./src/secp256k1/*" -exec shellcheck {} + || true

# === Lint: Python Scripts ===
if command -v flake8 >/dev/null 2>&1; then
  find . -type f -name "*.py" ! -path "./depends/*" -exec flake8 {} +
else
  echo "flake8 not installed, skipping Python lint."
fi

# === Lint: C++ Style Check (clang-format) ===
if command -v clang-format >/dev/null 2>&1; then
  echo "Checking C++ files with clang-format..."
  find src/ -type f \( -name "*.cpp" -o -name "*.h" \) \\
    ! -path "src/secp256k1/*" \\
    ! -path "src/univalue/*" \\
    -exec clang-format --dry-run --Werror {} +
else
  echo "clang-format not installed, skipping C++ format check."
fi

echo ">> Bitnion linting completed."
