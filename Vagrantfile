require "yaml"

if File.file?('settings.yml')
  settings = YAML.load_file('settings.yml')
else
  raise "Keine Konfigurationsdatei settings.yml gefunden"
end

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.define "lxd" do |lxd|
		lxd.vm.box = "bento/ubuntu-17.04"
		lxd.vm.network "private_network", ip: settings["lxd"]["ip"]
		lxd.vm.hostname = settings["lxd"]["hostname"]

		if Vagrant.has_plugin?("vagrant-disksize")
			lxd.disksize.size = settings["lxd"]["disksize"]
		end

		lxd.vm.provider "virtualbox" do |vb|
			vb.memory = settings["lxd"]["ram"]
			vb.cpus = settings["lxd"]["cpu"]
			vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
			if settings["lxd"]["mac"]
				vb.customize ["modifyvm", :id, "--macaddress2", settings["lxd"]["mac"]]
			end
		end

		lxd.vm.provision :shell, path: "scripts/base.sh"
		lxd.vm.provision :shell, path: "scripts/lxd.sh", args: [settings["lxd"]["password"]]
    lxd.vm.provision :shell, path: "scripts/jlxd.sh", run: "always"
	end

	config.vm.define "devstack" do |devstack|
		devstack.vm.box = "bento/ubuntu-17.04"

		devstack.vm.network "private_network", ip: settings["devstack"]["ip"]

		devstack.vm.hostname = settings["devstack"]["hostname"]

		if Vagrant.has_plugin?("vagrant-disksize")
			devstack.disksize.size = settings["devstack"]["disksize"]
		end

		devstack.vm.provider "virtualbox" do |vb|
			vb.memory = settings["devstack"]["ram"]
			vb.cpus = settings["devstack"]["cpu"]
			vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
      if settings["devstack"]["mac"]
        vb.customize ["modifyvm", :id, "--macaddress2", settings["devstack"]["mac"]]
      end
		end

		devstack.vm.provision :shell, path: "scripts/base.sh"
		devstack.vm.provision :shell, path: "scripts/routing.sh", args: [settings["devstack"]["interface"]]
		devstack.vm.provision :shell, path: "scripts/devstack.sh", args: [
																			settings["devstack"]["ip"],
																			settings["devstack"]["floating_range"],
																			settings["devstack"]["password"]
																		]

	end

	config.vm.define "terraform" do |terraform|
		terraform.vm.box = "bento/ubuntu-17.04"

		if Vagrant.has_plugin?("vagrant-disksize")
			terraform.disksize.size = settings["terraform"]["disksize"]
		end

		terraform.vm.network "private_network", ip: settings["terraform"]["ip"]
		terraform.vm.hostname = settings["terraform"]["hostname"]

		terraform.vm.provider "virtualbox" do |vb|
			vb.memory = settings["terraform"]["ram"]
			vb.cpus = settings["terraform"]["cpu"]
		end

		terraform.vm.provision :shell, path: "scripts/base.sh"
		terraform.vm.provision :shell, path: "scripts/terra.sh"
	end
end
