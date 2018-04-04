
#apt-get install --no-install-recommends -y docker.io python-pip python-dev libffi-dev gcc libssl-dev python-selinux
apt-get install --no-install-recommends -y python-pip python-dev libffi-dev gcc libssl-dev python-selinux apt-transport-https ca-certificates curl software-properties-common
pip install -U pip
pip install -U setuptools
pip install -U ansible

cat << EOF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking=False
pipelining=True
forks=100
EOF

#mkdir -p /etc/systemd/system/docker.service.d
#tee /etc/systemd/system/docker.service.d/kolla.conf <<-'EOF'
#[Service]
#MountFlags=shared
#EOF

#systemctl daemon-reload
#systemctl restart docker

#pip install -U docker

apt-get -y remove lxd lxc
