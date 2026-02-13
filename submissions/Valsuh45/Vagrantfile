Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.hostname = "hardened-lab-vm"
  config.vm.network "private_network", ip: "192.168.56.10"

  # Fixed Provisioning: Seed and run cloud-init without reboot
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    mkdir -p /var/lib/cloud/seed/nocloud-net
    mv /tmp/user-data /var/lib/cloud/seed/nocloud-net/user-data
    mv /tmp/meta-data /var/lib/cloud/seed/nocloud-net/meta-data
    chmod 644 /var/lib/cloud/seed/nocloud-net/user-data /var/lib/cloud/seed/nocloud-net/meta-data
    
    # Clean and init without reboot
    cloud-init clean --logs
    cloud-init init
  SHELL

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "hardened-lab-vm"
  end
end