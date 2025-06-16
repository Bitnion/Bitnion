#!/usr/bin/env bash
#
# Generate manpages from Bitnion CLI --help output.
# Requires help2man and installed Bitnion binaries.
# Usage: ./gen-manpages.sh <path-to-bitnion-binaries>

set -e

# Check for required tools
if ! command -v help2man >/dev/null 2>&1; then
  echo "❌ help2man is required but not found. Please install it." >&2
  exit 1
fi

# Set paths
BINDIR=${1:-$(pwd)}
MANDIR=~/bitnion/doc/man

BITNIOND=${BINDIR}/bitniond
BITNIONCLI=${BINDIR}/bitnion-cli
BITNIONTX=${BINDIR}/bitnion-tx
BITNIONQT=${BINDIR}/qt/bitnion-qt  # Optional GUI

mkdir -p $MANDIR

echo "Generating manpages in $MANDIR"

# Generate manpages
for cmd in bitniond bitnion-cli bitnion-tx; do
  bin="${BINDIR}/${cmd}"
  if [ ! -x "$bin" ]; then
    echo "⚠️ Skipping $cmd: binary not found or not executable"
    continue
  fi
  help2man -N --version-string=1.0 --no-discard-stderr -o "${MANDIR}/${cmd}.1" "$bin"
  echo "✔️ Generated: ${MANDIR}/${cmd}.1"
done

# Optional: Qt wallet manpage
if [ -x "$BITNIONQT" ]; then
  help2man -N --version-string=1.0 --no-discard-stderr -o "${MANDIR}/bitnion-qt.1" "$BITNIONQT"
  echo "✔️ Generated: ${MANDIR}/bitnion-qt.1"
else
  echo "ℹ️ Qt wallet binary not found, skipping GUI manpage."
fi

echo "✅ All Bitnion manpages generated successfully."

