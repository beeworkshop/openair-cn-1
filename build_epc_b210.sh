#!/bin/bash

source oaienv

# Set host information
sudo hostname nano
sudo cp build_help/hosts /etc/hosts

# Start build
cd scripts
./build_mme -i --force
./build_hss -i --force
./build_spgw -i --force

# Copy config files
sudo mkdir -p /usr/local/etc/oai/freeDiameter
sudo cp ~/openair-cn/etc/acl.conf /usr/local/etc/oai/freeDiameter
sudo cp configs
