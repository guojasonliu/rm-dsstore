# rm-dsstore

A tiny CLI to recursively delete macOS `.DS_Store` files under a directory tree.

## Usage

```bash
# delete under current directory
rm-dsstore

# delete under a specific path
rm-dsstore ~/Projects

# multiple paths
rm-dsstore ~/code repo/website

# dry run (show what would be deleted)
rm-dsstore --dry-run ~/code

# verbose (prints progress)
rm-dsstore -v .
```

## Install (Makefile)

```bash
# from the repo root
make install            # installs to /usr/local/bin by default
# or customize
sudo make PREFIX=/opt/rm-dsstore install

# uninstall
sudo make uninstall      # uses the same PREFIX/BINDIR
```

> Variables: `PREFIX` (default `/usr/local`), `BINDIR` (default `$(PREFIX)/bin`).

## One-liner install (no Makefile)

```bash
sudo cp bin/rm-dsstore /usr/local/bin/ && sudo chmod +x /usr/local/bin/rm-dsstore
```

## Packaging

### Debian `.deb`

Two options:

**A) Minimal native build (no dependencies):**

```bash
./scripts/build-deb.sh 1.0.0
# Produces: dist/rm-dsstore_1.0.0_all.deb
```

**B) Using `fpm` (simpler if you have Ruby fpm):**

```bash
fpm -s dir -t deb -n rm-dsstore -v 1.0.0 \
	--license MIT --description "Delete .DS_Store recursively" \
	bin/rm-dsstore=/usr/local/bin/rm-dsstore
```

### RPM `.rpm`

**A) rpmbuild with the provided spec:**

```bash
./scripts/build-rpm.sh 1.0.0
# Produces: dist/rm-dsstore-1.0.0-1.noarch.rpm
```

**B) Using `fpm`:**

```bash
fpm -s dir -t rpm -n rm-dsstore -v 1.0.0 \
	--license MIT --description "Delete .DS_Store recursively" \
	bin/rm-dsstore=/usr/local/bin/rm-dsstore
```

### Homebrew / Linuxbrew

Use the provided formula (edit the URLs once your GitHub repo is live).

```bash
brew tap <your-username>/tools https://github.com/<your-username>/homebrew-tools
brew install rm-dsstore
# or directly from a raw formula file during development
brew install --formula packaging/brew/rm-dsstore.rb
```

**Note:** Update the `url`, `sha256`, and `version` in the formula after tagging a release.

## Notes

* This tool is intentionally minimal and safe. `--dry-run` is your friend before deleting.
* It uses `find` with `-name '.DS_Store' -type f -delete` under the hood.

## License

MIT — see [LICENSE](LICENSE).