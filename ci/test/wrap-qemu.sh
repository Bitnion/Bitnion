#!/usr/bin/env bash
#
# Bitnion (BNO) – QEMU Wrapper Script for Cross-Architecture Execution
#
# This script wraps the execution of cross-compiled Bitnion binaries
# using QEMU emulation. It enables seamless testing of binaries compiled
# for alternative architectures (e.g., aarch64, armhf, riscv64, s390x)
# within a native host environment.
#
# Adapted from Bitcoin Core test infrastructure, rewritten to support
# the Bitnion project’s naming, structure, and module architecture.
#

set -euo pipefail
export LC_ALL=C

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <qemu-binary> <binary-to-wrap> [args...]"
  echo "Example: ./wrap-qemu.sh qemu-aarch64 ./src/bitniond --version"
  exit 1
fi

QEMU_BINARY="$1"
shift

BINARY_TO_RUN="$1"
shift

if ! command -v "${QEMU_BINARY}" >/dev/null; then
  echo "❌ Error: QEMU binary '${QEMU_BINARY}' not found in PATH."
  exit 1
fi

if [[ ! -x "${BINARY_TO_RUN}" ]]; then
  echo "❌ Error: Target binary '${BINARY_TO_RUN}' is not executable."
  exit 1
fi

echo "🚀 Running: ${QEMU_BINARY} ${BINARY_TO_RUN} $@"
exec "${QEMU_BINARY}" "${BINARY_TO_RUN}" "$@"
