#!/bin/bash

# ethernet interface name
eth_name=$(nmcli dev status | grep ethernet | awk '{print $1}')

# wifi interface name
wifi_name=$(nmcli dev status | grep wifi | awk '{print $1}')

# wifi address
wifi_addr=$(ifconfig $wifi_name | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}')

# Get network mask
net_mask_ipv4=$(ifconfig $wifi_name | grep 'Mask:' | awk '{print $4}' | cut -d: -f2)
if [ $net_mask_ipv4 = '255.255.254.0' ]; then
   net_mask_cidr=23
elif [ $net_mask_ipv4 = '255.255.255.0' ]; then
   net_mask_cidr=24
else
   echo "Netmask is not 24 or 23!"
   exit
fi

local_config_dir=/usr/local/etc/oai

# Replace config info in mme, spgw,  config files
sudo sed -i "s/ETH_NAME_REPLACE/$eth_name/g"  $local_config_dir/mme.conf
sudo sed -i "s/ETH_NAME_REPLACE/$eth_name/g"  $local_config_dir/spgw.conf
sudo sed -i "s/WIFI_NAME_REPLACE/$wifi_name/g" $local_config_dir/spgw.conf
sudo sed -i "s/WIFI_IP_REPLACE/$wifi_addr/g"   $local_config_dir/spgw.conf
sudo sed -i "s/WIFI_NETMASK_REPLACE/$net_mask_cidr/g" $local_config_dir/spgw.conf
