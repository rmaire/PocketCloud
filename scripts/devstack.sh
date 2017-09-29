sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

sudo su - stack -c "git clone -b stable/pike https://github.com/rmaire/devstack.git /opt/stack/devstack"

sudo su - stack -c "echo [[local\|localrc]] > /opt/stack/devstack/local.conf"
sudo su - stack -c "echo ADMIN_PASSWORD=$3 >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo DATABASE_PASSWORD=$3 >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo RABBIT_PASSWORD=$3 >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo SERVICE_PASSWORD=$3 >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo HOST_IP=$1 >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo COMPRESS_OFFLINE=false >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo COMPRESS_ENABLED=false >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo disable_service tempest >> /opt/stack/devstack/local.conf"
sudo su - stack -c "echo FLOATING_RANGE=$2 >> /opt/stack/devstack/local.conf"

sudo su - stack -c "cd /opt/stack/devstack; ./stack.sh"
