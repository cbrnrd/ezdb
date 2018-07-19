#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
cd ..
username=$(whoami)

sed -i "s/root/$username/g" services/ezdb.service

cp services/ezdb.service /lib/systemd/system/ezdb.service

echo -e "Starting ezdb service..."

service ezdb start
