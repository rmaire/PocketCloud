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

    if settings["lxd"]["bridge"] && settings["lxd"]["bridge"]["public"]
      lxd.vm.network "public_network", auto_config: false
    end

		lxd.vm.hostname = settings["lxd"]["hostname"]

		if Vagrant.has_plugin?("vagrant-disksize")
			lxd.disksize.size = settings["lxd"]["disksize"]
		end

		lxd.vm.provider "virtualbox" do |vb|
			vb.memory = settings["lxd"]["ram"]
			vb.cpus = settings["lxd"]["cpu"]
			vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
			if settings["lxd"]["bridge"]
				vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
			end
			if settings["lxd"]["mac"]
				vb.customize ["modifyvm", :id, "--macaddress2", settings["lxd"]["mac"]]
			end
		end

		lxd.vm.provision :shell, path: "scripts/base.sh"
		lxd.vm.provision :shell, path: "scripts/lxd.sh", args: [settings["lxd"]["password"]]

    if settings["lxd"]["bridge"] && settings["lxd"]["bridge"]["public"]
      lxd.vm.provision :shell, path: "scripts/lxd-bridge.sh"
      if Vagrant.has_plugin?("vagrant-reload")
  			lxd.vm.provision :reload
  		end
      lxd.vm.provision :shell, path: "scripts/lxd-bridge-config.sh"
    end

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

	config.vm.define "controller" do |controller|
		controller.vm.box = "bento/ubuntu-17.04"

		if Vagrant.has_plugin?("vagrant-disksize")
			controller.disksize.size = settings["controller"]["disksize"]
		end

		controller.vm.network "private_network", ip: settings["controller"]["ip"]
		controller.vm.hostname = settings["controller"]["hostname"]

		controller.vm.provider "virtualbox" do |vb|
			vb.memory = settings["controller"]["ram"]
			vb.cpus = settings["controller"]["cpu"]
      vb.gui = settings["controller"]["desktop"]
		end

		controller.vm.provision :shell, path: "scripts/base.sh"
		controller.vm.provision :shell, path: "scripts/terra.sh"
    if settings["controller"]["desktop"]
      controller.vm.provision :shell, path: "scripts/desktop.sh"
      if Vagrant.has_plugin?("vagrant-reload")
  			controller.vm.provision :reload
  		end
    end
	end
end
