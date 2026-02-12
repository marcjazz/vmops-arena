Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Hardened-Lab-Blessing"
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Copy the file to the VM first
  config.vm.provision "file", source: "cloud-init/user-data", destination: "/tmp/user-data"

  # Run a script to place it correctly and trigger cloud-init
  config.vm.provision "shell", inline: <<-SHELL
    sudo mkdir -p /var/lib/cloud/seed/nocloud-net/
    sudo cp /tmp/user-data /var/lib/cloud/seed/nocloud-net/user-data
    sudo touch /var/lib/cloud/seed/nocloud-net/meta-data
    
    echo "Starting Cloud-Init process..."
    sudo cloud-init clean --logs
    sudo cloud-init init
    sudo cloud-init modules --mode=config
    sudo cloud-init modules --mode=final
  SHELL
end