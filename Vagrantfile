Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"

  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  # Copy cloud-init file
  config.vm.provision "file",
    source: "cloud-init/user-data.yaml",
    destination: "/tmp/user-data.yaml"

  # Run cloud-init manually
  config.vm.provision "shell", inline: <<-SHELL
    sudo cloud-init init --local
    sudo cloud-init single --file /tmp/user-data.yaml --name cc_custom --frequency always
  SHELL
end