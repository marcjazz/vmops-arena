Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "Hardened-Cloud-Instance"
  end

  config.vm.provision "file", source: "cloud-init/user-data", destination: "/tmp/user-data"

  config.vm.provision "shell", inline: <<-SHELL
    sudo cloud-init clean --logs
    sudo mkdir -p /var/lib/cloud/seed/nocloud-net
    sudo cp /tmp/user-data /var/lib/cloud/seed/nocloud-net/user-data
    sudo touch /var/lib/cloud/seed/nocloud-net/meta-data
    sudo cloud-init init
    sudo cloud-init modules --mode=config
    sudo cloud-init modules --mode=final
  SHELL
end