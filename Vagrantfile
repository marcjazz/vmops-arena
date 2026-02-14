# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Base box configuration
  config.vm.box = "bento/ubuntu-24.04"

  # VirtualBox provider settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = "hardened-cloud-instance"
    vb.memory = 1024
    vb.cpus = 1
  end

  # Private network with static IP
  config.vm.network "private_network", ip: "192.168.56.10"

  # Cloud-Init configuration
  # Note: bento boxes have cloud-init disabled by default, so we enable and run it manually
  config.vm.provision "file", source: "cloud-init/user-data", destination: "/tmp/user-data"

  config.vm.provision "shell", inline: <<-SHELL
    # Enable cloud-init (remove disabled marker)
    sudo rm -f /etc/cloud/cloud-init.disabled

    # Set up cloud-init with user-data (using nocloud-net datasource)
    sudo mkdir -p /var/lib/cloud/seed/nocloud-net
    sudo cp /tmp/user-data /var/lib/cloud/seed/nocloud-net/user-data
    sudo chmod 644 /var/lib/cloud/seed/nocloud-net/user-data

    # Create minimal meta-data file (required by cloud-init)
    echo "instance-id: vagrant-hardened-lab" | sudo tee /var/lib/cloud/seed/nocloud-net/meta-data

    # Run cloud-init to process user-data
    sudo cloud-init clean --logs
    sudo cloud-init init --local
    sudo cloud-init init
    sudo cloud-init modules --mode=config
    sudo cloud-init modules --mode=final
  SHELL
end
