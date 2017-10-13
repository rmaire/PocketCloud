echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.$1.proxy_arp = 1" >> /etc/sysctl.conf

sysctl -p

iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
iptables-save > /etc/iptables.conf 
echo "iptables-restore < /etc/iptables.conf" >> /etc/rc.local

ufw disable