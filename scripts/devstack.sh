sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo su - stack -c "git clone -b stable/pike https://git.openstack.org/openstack-dev/devstack"

sudo su - stack -c "cd devstack; git checkout -t origin/stable/pike"

sudo su - stack -c "echo [[local\|localrc]] > devstack/local.conf"
sudo su - stack -c "echo ADMIN_PASSWORD=$3 >> devstack/local.conf"
sudo su - stack -c "echo DATABASE_PASSWORD=$3 >> devstack/local.conf"
sudo su - stack -c "echo RABBIT_PASSWORD=$3 >> devstack/local.conf"
sudo su - stack -c "echo SERVICE_PASSWORD=$3 >> devstack/local.conf"
sudo su - stack -c "echo HOST_IP=$1 >> devstack/local.conf"
sudo su - stack -c "echo COMPRESS_OFFLINE=false >> devstack/local.conf"
sudo su - stack -c "echo COMPRESS_ENABLED=false >> devstack/local.conf"
sudo su - stack -c "echo disable_service tempest >> devstack/local.conf"
sudo su - stack -c "echo FLOATING_RANGE=$2 >> devstack/local.conf"

sudo su - stack -c "cd devstack; ./stack.sh"
