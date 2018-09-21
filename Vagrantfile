# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.vm.box = "centos/7"

	# workaround vagrant bug for private interface
	config.vm.provision "shell", run: "always", inline: <<-SHELL
		ifup eth1
	SHELL

	config.vm.define "target" do |target|
		target.vm.hostname = "nvmetcp-target"
		target.vm.network "private_network", ip: "192.168.33.10"
		target.vm.provision "shell", path: "target-provision.sh"
		# initialize nvme-tcp target
		target.vm.provision "shell", run: "always", path: "target-setup.sh"
	end

	config.vm.define "initiator" do |initiator|
		initiator.vm.hostname = "nvmetcp-initiator"
		initiator.vm.network "private_network", ip: "192.168.33.100"
		initiator.vm.provision "shell", path: "initiator-provision.sh"
		# connect initiator to target
		initiator.vm.provision "shell", run: "always", inline: <<-SHELL
			modprobe nvme_tcp
			nvme connect -t tcp -a 192.168.33.10 -s 11345 -n ramdisk
		SHELL
	end

end
