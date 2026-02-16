Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"

  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  # Ensure cloud-init is ready + clean previous runs
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y cloud-init

    # Enable cloud-init services
    systemctl enable cloud-init-local.service
    systemctl enable cloud-init.service
    systemctl enable cloud-config.service
    systemctl enable cloud-final.service

    cloud-init clean --logs --seed
  SHELL

  # Copy user-data (note: rename to .yaml if yours isn't)
  config.vm.provision "file",
    source: "cloud-init/user-data.yaml",
    destination: "/tmp/user-data.yaml"

  # Force NoCloud datasource + run cloud-init manually
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /var/lib/cloud/seed/nocloud-net

    cp /tmp/user-data.yaml /var/lib/cloud/seed/nocloud-net/user-data

    cat > /var/lib/cloud/seed/nocloud-net/meta-data <<EOF
instance-id: vagrant-$(date +%s)
local-hostname: vagrant
EOF

    cat > /etc/cloud/cloud.cfg.d/90_nocloud.cfg <<EOF
datasource_list: [ NoCloud, None ]
EOF

    cloud-init init --local
    cloud-init init
    cloud-init modules --mode=config
    cloud-init modules --mode=final
    cloud-init status --wait
  SHELL
end