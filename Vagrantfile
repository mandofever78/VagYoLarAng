# -*- mode: ruby -*-
# vi: set ft=ruby :

#require "#{File.dirname(__FILE__)}/vagrant/artisan.rb"
#require "#{File.dirname(__FILE__)}/vagrant/composer.rb"

Vagrant.configure("2") do |config|
config.vm.define :vagrant do |vgr_config|
   vgr_config.vm.box = "precise32"
   vgr_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
   
   if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
   
       vgr_config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
       vgr_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
       vgr_config.vm.network :forwarded_port, guest: 9000, host: 9000, auto_correct: true
       vgr_config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true
       vgr_config.vm.host_name = "vagrant"
       vgr_config.vm.synced_folder "www", "/var/www", {:mount_options =>   ['dmode=777,fmode=777']}
       vgr_config.vm.provision :shell, :inline => "echo \"America/Chicago\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
       vgr_config.vm.provider :virtualbox do |vb|
       vb.customize ["modifyvm", :id, "--memory", "512"]
       end

       vgr_config.vm.provision :puppet do |puppet|
         puppet.manifests_path = "puppet/manifests"
         puppet.manifest_file  = "default.pp"
         puppet.module_path = "puppet/modules"
        #puppet.options = "--verbose --debug"
       end

       vgr_config.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"
       end
   
   end
 
end 