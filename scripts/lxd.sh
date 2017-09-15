apt-get install lxd lxd-tools -y

lxd init --auto --storage-backend dir --network-address 0.0.0.0 --network-port 8443 --trust-password $1

lxc network create bridged
lxc network attach-profile bridged default eth0
