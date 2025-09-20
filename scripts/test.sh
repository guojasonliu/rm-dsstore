#!/usr/bin/env bash
set -euo pipefail

# Simple tests for rm-dsstore
ROOT=$(cd "$(dirname "$0")/.." && pwd)
CLI="$ROOT/bin/rm-dsstore"

# Create a temporary test tree
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/dir1/dir2" "$TMP/other"
# create .DS_Store files
touch "$TMP/.DS_Store"
touch "$TMP/dir1/.DS_Store"
touch "$TMP/dir1/dir2/.DS_Store"
touch "$TMP/other/.DS_Store"

# Dry-run should list files but not delete
OUT=$($CLI -n -v "$TMP" 2>&1)
if ! echo "$OUT" | grep -q ".DS_Store"; then
  echo "Dry-run did not report .DS_Store files" >&2
  echo "$OUT" >&2
  exit 2
fi

# Actual delete
$CLI -v "$TMP"

# Ensure no .DS_Store remain
if find "$TMP" -type f -name '.DS_Store' | read; then
  echo "Some .DS_Store files were not deleted" >&2
  find "$TMP" -type f -name '.DS_Store' -print >&2
  exit 3
fi

echo "All tests passed"
