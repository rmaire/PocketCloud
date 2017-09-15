mkdir terraform
cd terraform
wget https://releases.hashicorp.com/terraform/0.9.10/terraform_0.9.10_linux_amd64.zip
unzip terraform_0.9.10_linux_amd64.zip
cp terraform /usr/local/bin
wget https://github.com/sl1pm4t/terraform-provider-lxd/releases/download/v0.9.8/terraform-provider-lxd_v0.9.8_linux_amd64.tar.gz
tar xzf terraform-provider-lxd_v0.9.8_linux_amd64.tar.gz
cp terraform-provider-lxd /usr/local/bin
rm terraform*
cd ..
rm -rf terraform
