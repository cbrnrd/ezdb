#!/bin/bash

set -e

echo -e "Building deb for all architectures using \`fpm\`..."
echo -e "Using version $1"

fpm -t deb --url https://github.com/cbrnrd/ezdb -a all -n ezdb -m @cbrnrd -s dir -f --license MIT -v $1 --deb-systemd services/ezdb.service bin/ezdb=/usr/bin/ezdb
