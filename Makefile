CRYSTAL_BIN ?= $(shell which crystal)
BOJACK_BIN ?= $(shell which ezdb)
# `command -v` doesn't work here for some reason
PREFIX ?= /usr/local

build:
	$(CRYSTAL_BIN) deps
	$(CRYSTAL_BIN) build --release -o bin/ezdb src/ezdb/main.cr $(CRFLAGS)

clean:
	rm -f ./bin/ezdb

test:
	$(CRYSTAL_BIN) spec --verbose

spec: test

install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/ezdb $(PREFIX)/bin
	# TODO add systemd script

reinstall: build
	cp -rf ./bin/ezdb $(BOJACK_BIN)
