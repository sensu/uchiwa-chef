Vagrant.configure("2") do |config|
  config.vm.hostname = "uchiwa-berkshelf"
  config.vm.box = "opscode-centos-6.5"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }

    chef.run_list = [
      "recipe[uchiwa::default]"
    ]
  end
end
