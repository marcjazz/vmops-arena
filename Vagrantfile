Vagrant.configure("2") do |config|
  # Base box - Ubuntu 24.04
  config.vm.box = "bento/ubuntu-24.04"
  
  # VM hostname
  config.vm.hostname = "hardened-cloud"
  
  # Private network with static IP
  config.vm.network "private_network", ip: "192.168.56.10"
  
  # VirtualBox provider configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "hardened-vagrant-lab"
    vb.memory = "2048"
    vb.cpus = 2
  end
  
  # Cloud-Init provisioning
  config.vm.provision "file", 
    source: "cloud-init/user-data", 
    destination: "/tmp/user-data"
  
  config.vm.provision "shell", inline: <<-SHELL
    # Install cloud-init if not present
    if ! command -v cloud-init &> /dev/null; then
      apt-get update
      apt-get install -y cloud-init
    fi
    
    # Copy user-data to cloud-init directory
    mkdir -p /var/lib/cloud/seed/nocloud-net
    cp /tmp/user-data /var/lib/cloud/seed/nocloud-net/user-data
    
    # Create empty meta-data (required by cloud-init)
    echo "instance-id: vagrant-hardened-lab" > /var/lib/cloud/seed/nocloud-net/meta-data
    
    # Run cloud-init
    cloud-init clean --logs
    cloud-init init --local
    cloud-init init
    cloud-init modules --mode=config
    cloud-init modules --mode=final
  SHELL
end
