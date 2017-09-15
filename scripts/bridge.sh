apt-get install bridge-utils -y

cat <<EOF >> /etc/network/interfaces

auto br0
iface br0 inet static
	address $1
	netmask $2
	network $3
	broadcast $4
	gateway $5
	dns-nameservers $6
	bridge_ports $7
	bridge_stp off
	bridge_maxwait 0
EOF
