$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$ruby_version = '2.1.1'

class must-have {
  include apt
  include mysql
  include phpmyadmin
  include php
  include php55
  include apache
  include composer
  include wget
  include nodejs
  include laravel-app

  
  Exec {
    path => '/usr/local/bin:/usr/bin:/bin',
  }
  
  exec { 'apt-getupdate':
    command => '/usr/bin/apt-get update',
    require => Exec['add php55 apt-repo']
  }

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    before => Package["nodejs"],
  }

  exec { 'apt-get update 2':
    command => '/usr/bin/apt-get update',
    require => Package["nodejs"],
  }
  
  package { ["yo",
             "generator-angular",
             "generator-karma"]:
    ensure => present,
    require => [ Exec["apt-get update 2"], Package["nodejs"] ],
    provider => "npm",
  }

  file { ["/vagrant/www/angular"]:
      ensure => "directory",
      before => Package['generator-angular'],
  }
  
  package { ["curl",
             "bash",
             "git-core",
             "build-essential",
             "phantomjs",
             "fontconfig"]:
    ensure => present,
    require => Exec["apt-get update 2"],
  }
  
  package { ['sass', 'compass']:
      ensure => 'installed',
      provider => 'gem',
      require => Package['nodejs']
  }

  if $virtual == "virtualbox" and $fqdn == '' {
       $fqdn = "localhost"
  }
}

include must-have
