# -*- mode: ruby -*-
# vi: set ft=ruby :

#require "#{File.dirname(__FILE__)}/vagrant/artisan.rb"
#require "#{File.dirname(__FILE__)}/vagrant/composer.rb"

Vagrant.configure("2") do |config|
config.vm.define :vagrant do |vgr_config|
   vgr_config.vm.box = "precise32"
   vgr_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
   
   if Vagrant.has_plugin?("vagrant-cachier")
    vgr_config.cache.scope = :box
    vgr_config.cache.synced_folder_opts = {
      type: :nfs,
      # The nolock option can be useful for an NFSv3 client that wants to avoid the
      # NLM sideband protocol. Without this option, apt-get might hang if it tries
      # to lock files needed for /var/cache/* operations. All of this can be avoided
      # by using NFSv4 everywhere. Please note that the tcp option is not the default.
      mount_options: ['rw', 'vers=3', 'nolock']
    }
   
       vgr_config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
       vgr_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
       vgr_config.vm.network :forwarded_port, guest: 9000, host: 9000, auto_correct: true
       vgr_config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true
       vgr_config.vm.network "private_network", type: "dhcp", auto_config: false
       vgr_config.vm.host_name = "vagrant"
       vgr_config.vm.synced_folder "www", "/var/www"
       vgr_config.vm.provision :shell, :inline => "echo \"America/Chicago\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
       vgr_config.vm.provider :virtualbox do |vb|
       vb.customize ["modifyvm", :id, "--memory", "1024"]
       end

       vgr_config.vm.provision :puppet do |puppet|
         puppet.manifests_path = "puppet/manifests"
         puppet.manifest_file  = "default.pp"
         puppet.module_path = "puppet/modules"
         #puppet.options = "--verbose --debug"
       end

       vgr_config.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"
       vgr_config.vm.provision :shell, :path => "puppet/scripts/custom_bash.sh"
       end
   
   end
 
end
