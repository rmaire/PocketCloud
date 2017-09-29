apt-get install lxd lxd-tools -y
apt-get install default-jdk maven -y

lxd init --auto --storage-backend dir --network-address 0.0.0.0 --network-port 8443 --trust-password $1

#lxc network create bridged
#lxc network attach-profile bridged default eth0

wget https://github.com/rmaire/jlxd/releases/download/1.0/jlxd.jar
cp jlxd.jar /usr/local/bin
