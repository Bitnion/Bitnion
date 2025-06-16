#!/usr/bin/env bash
#
# Bitnion Core - UTXO Snapshot Generation Script
#
# This script generates a UTXO snapshot from an already synchronized
# Bitnion node. The snapshot can be used to bootstrap other nodes or for analysis.
# Make sure bitniond is running with txindex=1 and sufficient chainstate.

set -e

DATADIR=${DATADIR:-~/.bitnion}
OUTDIR="utxo-snapshot-$(date +%Y%m%d_%H%M%S)"
SNAPSHOT_FILE="utxo-snapshot.dat"
BLOCKHASH_FILE="snapshot-blockhash.txt"

mkdir -p "$OUTDIR"

echo "📡 Fetching current best block hash..."
BLOCKHASH=$(bitnion-cli -datadir="$DATADIR" getbestblockhash)

if [ -z "$BLOCKHASH" ]; then
    echo "❌ Failed to retrieve best block hash from bitniond"
    exit 1
fi

echo "📌 Best block: $BLOCKHASH"

echo "📥 Exporting UTXO snapshot to $OUTDIR/$SNAPSHOT_FILE..."
bitnion-cli -datadir="$DATADIR" dumptxoutset "$OUTDIR/$SNAPSHOT_FILE"

echo "$BLOCKHASH" > "$OUTDIR/$BLOCKHASH_FILE"
echo "🗂️  Snapshot complete."
echo "📁 Output directory: $OUTDIR"
echo "📄 Block hash file:  $OUTDIR/$BLOCKHASH_FILE"
echo "🪙 UTXO snapshot:    $OUTDIR/$SNAPSHOT_FILE"

