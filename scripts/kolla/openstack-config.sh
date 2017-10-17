source /etc/kolla/admin-openrc.sh

wget http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
openstack image create "Cirros 0.3.5" --file cirros-0.3.5-x86_64-disk.img --disk-format qcow2 --container-format bare --public

wget http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
openstack image create "Ubuntu Xenial" --file xenial-server-cloudimg-amd64-disk1.img --disk-format qcow2 --container-format bare --public

openstack network create  --share --external --provider-physical-network physnet1 --provider-network-type flat provider
openstack subnet create --network provider --dns-nameserver $1 --allocation-pool start=$2,end=$3 --gateway $4 --subnet-range $5 provider
openstack flavor create --id 0 --vcpus 1 --ram 256 --disk 1 m1.nano
openstack flavor create --id 1 --vcpus 1 --ram 1024 --disk 10 m1.medium
openstack security group rule create --proto icmp default
openstack security group rule create --proto tcp --dst-port 22 default