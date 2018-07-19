#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

cd ../man

sudo cp ezdb.1 /usr/local/share/man/man1/
