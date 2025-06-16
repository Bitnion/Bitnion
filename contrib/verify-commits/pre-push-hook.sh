#!/usr/bin/env bash
# Bitnion (BNO) – Git Pre-Push Hook
#
# This hook ensures all pushed commits conform to Bitnion's
# commit verification standards before being accepted upstream.
#
# Compatible with local Git, GitHub, GitLab, and self-hosted repos.

set -e

# Resolve full path to repo root
ROOT_DIR="$(git rev-parse --show-toplevel)"
HOOK_SCRIPT="$ROOT_DIR/contrib/verify-commits/verify-commits.py"

# Check if verification script exists and is executable
if [ ! -x "$HOOK_SCRIPT" ]; then
  echo "❌ ERROR: verify-commits.py not found or not executable at:"
  echo "   $HOOK_SCRIPT"
  exit 1
fi

echo "🔍 Bitnion pre-push: running commit verification..."
exec "$HOOK_SCRIPT"
