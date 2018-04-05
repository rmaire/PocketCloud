apt-get update -y
apt install -t xenial-backports lxd lxd-client lxd-tools -y
apt-get install default-jdk maven -y

lxd init --auto --storage-backend dir --network-address 0.0.0.0 --network-port 8443 --trust-password $1

wget -q https://github.com/rmaire/jlxd/releases/download/1.0/jlxd.jar
cp jlxd.jar /usr/local/bin
