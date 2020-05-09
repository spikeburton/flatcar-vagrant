# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Initialize variables
num_nodes = 3
vm_gui = false
vm_cpus = 1
vm_memory = 1024

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "flatcar-stable"
  config.ssh.username = 'core'
  config.ssh.insert_key = true
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # Tell Vagrant that so it can be smarter.
    vb.check_guest_additions = false
    vb.functional_vboxsf = false
  end

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  (1..num_nodes).each do |i|
    vm_name = "node-#{i}"
    config.vm.define vm_name do |node_config|
      node_config.vm.hostname = vm_name

      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine. In the example below,
      # accessing "localhost:8080" will access port 80 on the guest machine.
      # NOTE: This will enable public access to the opened port
      # config.vm.network "forwarded_port", guest: 80, host: 8080

      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine and only allow access
      # via 127.0.0.1 to disable public access
      # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

      # Create a private network, which allows host-only access to the machine
      # using a specific IP.
      ip = "192.168.33.#{i+10}"
      node_config.vm.network "private_network", ip: ip

      # Create a public network, which generally matched to bridged network.
      # Bridged networks make the machine appear as another physical device on
      # your network.
      # config.vm.network "public_network"

      # Share an additional folder to the guest VM. The first argument is
      # the path on the host to the actual folder. The second argument is
      # the path on the guest to mount the folder. And the optional third
      # argument is a set of non-required options.
      # config.vm.synced_folder "../data", "/vagrant_data"
      node_config.vm.synced_folder "./share", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']

      # Provider-specific configuration so you can fine-tune various
      # backing providers for Vagrant. These expose provider-specific options.
      # Example for VirtualBox:
      #
      node_config.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine
        vb.gui = vm_gui

        # Name the VM
        vb.name = "flatcar-node-#{i}"

        # Customize the amount of memory on the VM:
        vb.memory = vm_memory
        vb.cpus = vm_cpus
      end
      #
      # View the documentation for the provider you are using for more
      # information on available options.
    end
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
