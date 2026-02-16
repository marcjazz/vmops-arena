Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "vmware_desktop" do |vm|
    vm.vmx["memsize"] = "2048"
    vm.vmx["numvcpus"] = "2"
    vm.linked_clone = false
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt update
    apt install -y nginx git zsh
    systemctl enable nginx
    systemctl start nginx
  SHELL
end
