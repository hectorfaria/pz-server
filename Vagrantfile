# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
    config.hostmanager.manage_host = true

    config.vm.define "pzserver" do |pzserver|
      pzserver.vm.box = "bento/ubuntu-22.04"
                   pzserver.vm.hostname = "pzserver"
                       pzserver.vm.network "private_network", ip: "192.168.56.12"
                               pzserver.vm.provider "virtualbox" do |vb|
                                      vb.memory = "8000"
                                      vb.cpus = 2              
                               
                                end

                                  end
end
