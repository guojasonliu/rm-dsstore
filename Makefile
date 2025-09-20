PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
NAME := rm-dsstore
SRC := bin/$(NAME)
DEST := $(BINDIR)/$(NAME)

.PHONY: all install uninstall fmt lint clean check

all:
	@echo "$(NAME) is a shell script; use 'make install' to install."

install:
	@mkdir -p $(BINDIR)
	@install -m 0755 $(SRC) $(DEST)
	@echo "Installed $(DEST)"

uninstall:
	@if [ -f "$(DEST)" ]; then rm -f "$(DEST)" && echo "Removed $(DEST)"; else echo "$(DEST) not found"; fi

fmt:
	@echo "Nothing to format (shell script)"

lint:
	@command -v shellcheck >/dev/null 2>&1 && shellcheck $(SRC) || echo "shellcheck not installed; skipping"

check:
	@echo "Running quick checks: bash -n, shellcheck (if available), tests"
	@bash -n $(SRC) && echo "bash syntax: OK"
	@$(MAKE) lint
	@./scripts/test.sh

clean:
	@rm -rf dist