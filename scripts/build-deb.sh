#!/usr/bin/env bash
set -euo pipefail
VER=${1:-1.0.0}
ROOT=$(cd "$(dirname "$0")/.." && pwd)
DIST="$ROOT/dist"
PKGDIR="$DIST/deb/rm-dsstore"

rm -rf "$DIST"
mkdir -p "$PKGDIR/DEBIAN" "$PKGDIR/usr/local/bin"

# control file
sed "s/^Version:.*/Version: $VER/" "$ROOT/packaging/deb/DEBIAN/control" > "$PKGDIR/DEBIAN/control"

# payload
install -m 0755 "$ROOT/bin/rm-dsstore" "$PKGDIR/usr/local/bin/rm-dsstore"

# build
OUT="$DIST/rm-dsstore_${VER}_all.deb"
DPKG_DEB=$(command -v dpkg-deb)
: "${DPKG_DEB:?dpkg-deb not found; install dpkg-dev}"
"$DPKG_DEB" --build "$PKGDIR" "$OUT"
echo "Built: $OUT"
