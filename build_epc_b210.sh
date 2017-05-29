#!/bin/bash

source oaienv

# Set host information
sudo hostname nano
sudo cp build_help/hosts /etc/hosts
sudo hostname nano

# Start build
cd scripts
./build_mme -i --force
./build_hss -i --force
./build_spgw -i --force
cd ..

# Copy config files
fd_dir=/usr/local/etc/oai/freeDiameter
sudo mkdir -p $fd_dir
sudo cp etc/acl.conf          $fd_dir
sudo cp configs/mme_fd.conf   $fd_dir
sudo cp configs/hss_fd.conf   $fd_dir
sudo cp configs/mme.conf      /usr/local/etc/oai
sudo cp configs/hss.conf      /usr/local/etc/oai
sudo cp configs/spgw.conf     /usr/local/etc/oai

# Install certs
cd scripts
./check_hss_s6a_certificate $fd_dir hss.openair4G.eur
./check_mme_s6a_certificate $fd_dir nano.openair4G.eur

# === HSS ===
./build_hss -c

# Run mysql configuration script
cd ../build_help
./mysql_secure.sh
cd ../scripts

# === MME ===
./build_mme -c

# === SPGW ===
./build_spgw -c

# == manual stuff todo after ==
# - modify config files with correct wifi IP
# - modify interface names to match current computer
# - manually set ethernet IP to 192.168.12.81
../build_help/config_modify.sh
