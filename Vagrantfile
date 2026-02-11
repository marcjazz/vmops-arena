Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.hostname = "hardened-cloud"

  # Static private IP
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "bryan-vm"
    vb.memory = "2048"
    vb.cpus = 2

    # Create a dedicated secondary SATA controller for the Cloud-Init ISO
    vb.customize ["storagectl", :id, "--name", "CloudInit", "--add", "sata", "--portcount", 1]

    # Attach the ISO to the dedicated controller
    vb.customize ["storageattach", :id,
                  "--storagectl", "CloudInit",
                  "--port", 0,
                  "--device", 0,
                  "--type", "dvddrive",
                  "--medium", "cidata.iso"]
  end
end