# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.hostname = 'vagrant-centos7'
    config.vm.provider :digital_ocean do |provider, override|
    config.vm.provision :shell, :path => "provision.sh"
    override.ssh.private_key_path = '~/.ssh/id_ecdsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    provider.backups_enabled = "false"
    provider.token = ENV['DIGITAL_OCEAN_TOKEN']
    provider.image = 'centos-7-x64'
    provider.region = 'nyc2'
    provider.size = '2gb'
    end
end
