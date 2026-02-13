# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # 1. Base Image
  config.vm.box = "bento/ubuntu-24.04"

  # 2. Networking
  config.vm.network "private_network", ip: "192.168.56.10"

  # 3. Hardware Resources
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # 4. THE ROBUST FIX: Manually inject the user-data file
  config.vm.provision "shell", inline: <<-SHELL
    echo "Injecting Cloud-Init Configuration..."
    mkdir -p /var/lib/cloud/seed/nocloud-net/
    cp /vagrant/user-data /var/lib/cloud/seed/nocloud-net/user-data
    echo "instance-id: vagrant-lab-node" > /var/lib/cloud/seed/nocloud-net/meta-data
    
    # Force Cloud-Init to run
    cloud-init clean
    cloud-init init --local
    cloud-init init
    cloud-init modules --mode=config
    cloud-init modules --mode=final
    
    echo "Cloud-Init Injection Complete!"
  SHELL
end
