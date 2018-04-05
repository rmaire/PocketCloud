apt-get install bridge-utils -y

ufw disable

cat <<EOF >> /etc/network/interfaces

auto eth2
iface eth2 inet manual

auto br0
iface br0 inet dhcp
	bridge_ports eth2
	bridge_stp off
	bridge_maxwait 0
EOF

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

sysctl -p
