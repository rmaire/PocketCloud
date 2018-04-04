pip install -U kolla-ansible
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/kolla/
cp /usr/local/share/kolla-ansible/ansible/inventory/* .

kolla-genpwd

sed -i "s/^#network_interface.*/network_interface: $1/" /etc/kolla/globals.yml
sed -i "s/^#neutron_external_interface.*/neutron_external_interface: $2/" /etc/kolla/globals.yml
sed -i "s/^kolla_internal_vip_address.*/kolla_internal_vip_address: $3/" /etc/kolla/globals.yml
sed -i "s/^#kolla_base_distro.*/kolla_base_distro: \"ubuntu\"/" /etc/kolla/globals.yml
sed -i "s/^#kolla_install_type.*/kolla_install_type: \"source\"/" /etc/kolla/globals.yml
sed -i "s/^#openstack_release.*/openstack_release: \"queens\"/" /etc/kolla/globals.yml
sed -i "s/^keystone_admin_password.*/keystone_admin_password: $4/" /etc/kolla/passwords.yml

kolla-ansible -i all-in-one bootstrap-servers

mkdir -p /etc/systemd/system/docker.service.d
tee /etc/systemd/system/docker.service.d/kolla.conf <<-'EOF'
[Service]
MountFlags=shared
EOF

systemctl daemon-reload
systemctl restart docker

mkdir -p /etc/kolla/config/nova
cat << EOF > /etc/kolla/config/nova/nova-compute.conf
[libvirt]
virt_type = qemu
cpu_mode = none
EOF

kolla-ansible pull -i /home/vagrant/all-in-one
kolla-ansible deploy -i /home/vagrant/all-in-one
kolla-ansible post-deploy
pip install python-openstackclient python-glanceclient python-neutronclient
source /etc/kolla/admin-openrc.sh
#/usr/local/share/kolla-ansible/init-runonce
