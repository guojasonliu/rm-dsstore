#!/usr/bin/env bash
set -euo pipefail
VER=${1:-1.0.0}
ROOT=$(cd "$(dirname "$0")/.." && pwd)
DIST="$ROOT/dist"
SPEC="$ROOT/packaging/rpm/rm-dsstore.spec"

# Create a temp build root
BUILDROOT="$(mktemp -d)"
trap 'rm -rf "$BUILDROOT"' EXIT

mkdir -p "$BUILDROOT/usr/local/bin"
install -m 0755 "$ROOT/bin/rm-dsstore" "$BUILDROOT/usr/local/bin/rm-dsstore"

# rpmbuild expects a spec, but we can use fpm as a fallback if rpmbuild is absent
if command -v rpmbuild >/dev/null 2>&1; then
  mkdir -p "$DIST"
  rpmbuild \
    -bb "$SPEC" \
    --define "_topdir $ROOT/dist/rpm" \
    --define "_buildrootdir $BUILDROOT" \
    --define "version $VER"
  echo "RPMs under: $ROOT/dist/rpm/RPMS"
else
  echo "rpmbuild not found; trying fpm"
  if command -v fpm >/dev/null 2>&1; then
    mkdir -p "$DIST"
    fpm -s dir -t rpm -n rm-dsstore -v "$VER" \
      --license MIT --description "Delete .DS_Store recursively" \
      "$BUILDROOT/usr/local/bin/rm-dsstore=/usr/local/bin/rm-dsstore" \
      -p "$DIST"
    echo "RPM under: $DIST"
  else
    echo "Neither rpmbuild nor fpm found. Install one of them and retry." >&2
    exit 1
  fi
fi
