#!/bin/bash

username="acm"
map_file="/home/$username/.scripts/setip/mac2ip.txt"
log_file="/home/$username/.scripts/setip/log.txt"

exec > >(tee -a "$log_file") 2>&1
date

###

interfaces=$(ip link show | awk -F ': ' '/^[0-9]+:/ {print $2}')
for interface_for in $interfaces; do
    mac_address=$(ip link show "$interface_for" | awk '/ether/ {print $2}')
    ip_address=$(awk -v mac="$mac_address" '$1 == mac {print $2}' "$map_file")
    interface=$interface_for
    
    echo $interface
    echo $mac_address
    echo $ip_address
    
    if [[ -n "$ip_address" ]]; then
        echo "MAC address $mac_address found, IP address is $ip_address"
        break
    fi
done

if [[ -z "$ip_address" ]]; then
    echo "No matching IP address found for any MAC address."
    exit 1
fi

location=$(awk -v mac="$mac_address" '$1 == mac {print $3}' "$map_file")
if [ "$location" == "A201" ]; then
    gateway="10.2.1.1"
elif [ "$location" == "A301" ]; then
    gateway="10.254.31.1"
else
    exit 1
fi

echo "$mac_address"
echo "$ip_address"
echo "$gateway"
# exit 0

# Define network configuration content, embedding the variable into the configuration
network_config=$(cat <<EOF
network:
  ethernets:
    $interface:
      dhcp4: false
      addresses:
        - $ip_address/24
      routes:
        - to: default
          via: $gateway
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
  version: 2
EOF
)

# Write the configuration to the file
echo "$network_config" | sudo tee /etc/netplan/01-network-manager-all.yaml > /dev/null

sudo systemctl start systemd-networkd

# Apply the configuration
sudo netplan apply
