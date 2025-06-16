#!/usr/bin/env bash
#
# Bitnion Core - Deterministic Coverage Verification Script
#
# This script runs the Bitnion unit tests twice and compares the generated
# coverage output to ensure the results are deterministic. This helps guarantee
# reliable coverage data for CI and long-term reproducibility.

set -e

if [ ! -d "src" ]; then
    echo "❌ This script must be run from the top-level Bitnion source directory."
    exit 1
fi

WORKDIR="contrib/devtools/coverage-test-tmp"
mkdir -p "$WORKDIR"

echo "🧪 Running first test pass with coverage..."
LCOV=1 TEST_BITNIONFORK=1 GTEST_OUTPUT=xml:"$WORKDIR"/gtest1.xml ./src/test/test_bitnion > "$WORKDIR"/output1.log

echo "📄 Saving .gcov files from first pass..."
find . -name "*.gcov" -exec cp {} "$WORKDIR"/1_{} \;

echo "🔁 Running second test pass with coverage..."
LCOV=1 TEST_BITNIONFORK=1 GTEST_OUTPUT=xml:"$WORKDIR"/gtest2.xml ./src/test/test_bitnion > "$WORKDIR"/output2.log

echo "📄 Saving .gcov files from second pass..."
find . -name "*.gcov" -exec cp {} "$WORKDIR"/2_{} \;

echo "🔍 Comparing first and second pass outputs for deterministic coverage..."
diff -rq "$WORKDIR" <(echo "$WORKDIR" | sed "s|/1_|/2_|g") | grep -vE "\\.log|\\.xml" || {
    echo "✅ Bitnion coverage is deterministic."
    rm -rf "$WORKDIR"
    exit 0
}

echo "❌ Non-deterministic coverage results detected!"
echo "Details saved in $WORKDIR for inspection."
exit 1

