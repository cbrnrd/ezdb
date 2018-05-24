#!/bin/bash

set -e

echo -e "Building ezdb..."

crystal build --release src/ezdb.cr

sudo mv ezdb /usr/bin/ezdb
username=$(whoami)

sudo sed -i "s/root/$username/g" services/ezdb.service

sudo cp services/ezdb.service /lib/systemd/system/ezdb.service

echo -e "Starting ezdb service..."

service ezdb start
