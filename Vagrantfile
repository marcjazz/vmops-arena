Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.provider "vmware_desktop" do |vm|
    vm.vmx["memsize"] = "2048"
    vm.vmx["numvcpus"] = "2"
    vm.linked_clone = false
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt update
    apt install -y nginx git
    systemctl enable nginx
    systemctl start nginx
  SHELL
end
