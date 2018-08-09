#!/bin/bash

set -e

if ! command -v crystal 2>/dev/null ; then
  echo "Installing crystal..."
  curl -sSL https://dist.crystal-lang.org/apt/setup.sh | sudo bash
  sudo apt-get install build-essential crystal
fi

git clone https://github.com/cbrnrd/ezdb
cd ezdb

echo "Building ezdb..."

make install

sudo cp bin/ezdb /usr/local/bin/ezdb
username=$(whoami)

sudo sed -i "s/root/$username/g" services/ezdb.service

sudo cp services/ezdb.service /lib/systemd/system/ezdb.service

sudo cp man/ezdb.1 /usr/local/share/man/man1/

cd ..
rm -rf ezdb/

echo -e "Starting ezdb service..."

service ezdb start
