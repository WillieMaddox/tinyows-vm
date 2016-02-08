# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "US/Central"
  end

  # Using vivid because pgrouting extension is available with apt-get.
  config.vm.box = "ubuntu/vivid64"
  config.vm.hostname = "tinyows-vm"
#  config.vm.network "private_network", ip: "172.16.5.80"
  #config.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true
  #config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 5432, host: 5432, auto_correct: true
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

  #config.ssh.forward_agent = true
  #config.vm.synced_folder "/media/maddoxw/Borg_LS/terrain/TCA_LiDAR", "/texas_data"

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.name = "tinyows-vivid64"
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.provision :shell, :path => "scripts/vagrant/installer.sh"
  config.vm.provision :shell, :path => "scripts/vagrant/tinyows0.sh"
  config.vm.provision :shell, :path => "scripts/vagrant/tinyows.sh"
  
end
