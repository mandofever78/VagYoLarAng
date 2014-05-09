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
  include ruby
  include wget
  
  apt::ppa { "ppa:chris-lea/node.js": }
  
  Exec {
    path => '/usr/local/bin:/usr/bin:/bin',
  }
  
  exec { 'apt-getupdate':
    command => '/usr/bin/apt-get update',
    require => Exec['add php55 apt-repo']
  }

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    before => Apt::Ppa["ppa:chris-lea/node.js"],
  }

  exec { 'apt-get update 2':
    command => '/usr/bin/apt-get update',
    require => Apt::Ppa["ppa:chris-lea/node.js"],
  }

  exec { 'install yeoman':
    command => '/usr/bin/npm install -g yo phantomjs',
    creates => [
      '/usr/lib/node_modules/bower/bin/bower',
      '/usr/lib/node_modules/yo/bin/yo',
      '/usr/lib/node_modules/grunt-cli/bin/grunt',
      '/usr/lib/node_modules/phantomjs/bin/phantomjs'
      ],
    require => [ Exec["apt-get update 2"], Package["nodejs"] ],
  }

  exec { 'install angular generator':
    command => '/usr/bin/npm install -g generator-angular',
    creates => '/usr/lib/node_modules/generator-angular',
    require => Exec["install yeoman"],
  }
  
  exec { 'install grunt':
    cwd => '/vagrant/www',
    command => '/usr/bin/npm install grunt',
    require => Exec['create angular site'],
  }

  file { "/vagrant/www":
      ensure => "directory",
      before => Exec['create angular site'],
      require => Exec['install angular generator'],
  }

  exec { 'create angular site':
    command => '/usr/bin/yes | /usr/bin/yo angular',
    cwd => '/vagrant/www',
    creates => '/vagrant/www/app',
    require => File["/vagrant/www"],
    returns => [0, 8]
  }

  file_line { "update hostname in gruntfile": 
    line => "\t\thostname: '0.0.0.0',", 
    path => "/vagrant/www/Gruntfile.js", 
    match => "hostname: '.*'", 
    ensure => present,
    require => Exec["create angular site"],
  }

  package { ["curl",
             "bash",
             "nodejs",
             "git-core",
             "build-essential",
             "fontconfig"]:
    ensure => present,
    require => Exec["apt-get update 2"],
  }
  
  package { ['sass', 'compass']:
      ensure => 'installed',
      provider => 'gem',
      require => Package['rubygems']
  }

  if $virtual == "virtualbox" and $fqdn == '' {
       $fqdn = "localhost"
  }
}

include must-have
