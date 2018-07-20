CRYSTAL_BIN ?= $(shell which crystal)
SHARDS_BIN ?= $(shell which shards)
EZDB_BIN ?= $(shell which ezdb)
# `command -v` doesn't work here for some reason
PREFIX ?= /usr/local

build:
	$(CRYSTAL_BIN) build --release -o bin/ezdb src/ezdb/main.cr $(CRFLAGS)

clean:
	rm -f ./bin/ezdb

test:
	$(CRYSTAL_BIN) spec --verbose

spec: test

deps:
	$(SHARDS_BIN)

install: deps build
	mkdir -p $(PREFIX)/bin
	cp ./bin/ezdb $(PREFIX)/bin
	$(shell sh scripts/install_service.sh)

reinstall: build
	cp -rf ./bin/ezdb $(EZDB_BIN)
