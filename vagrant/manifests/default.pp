$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$ruby_version = '2.1.1'

class must-have {
  include apt

  apt::ppa { "ppa:chris-lea/node.js": }

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

  file { "/home/vagrant/angular":
      ensure => "directory",
      before => Exec['create angular site'],
      require => Exec['install angular generator'],
  }

  exec { 'create angular site':
    command => '/usr/bin/yes | /usr/bin/yo angular',
    cwd => '/home/vagrant/angular',
    creates => '/home/vagrant/angular/app',
    require => File["/home/vagrant/angular"],
    logoutput => true,
    returns => [0, 8]
  }

  file_line { "update hostname in gruntfile": 
    line => "\t\t\t\thostname: '0.0.0.0'", 
    path => "/home/vagrant/angular/Gruntfile.js", 
    match => "hostname: '.*'", 
    ensure => present,
    require => Exec["create angular site"],
  }

  package { ["wget",
             "curl",
             "bash",
             "nodejs",
             "git-core",
             "build-essential",
             "fontconfig"]:
    ensure => present,
    require => Exec["apt-get update 2"],
  }

 # --- Ruby ---------------------------------------------------------------------

Exec {
  path => '/usr/local/bin:/usr/bin:/bin',
}

#    exec { 'install_rvm':
#      command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
#      creates => "/.rvm/bin/rvm",
#      require => Package['curl']
#    }

#    exec { 'install_ruby':
      # We run the rvm executable directly because the shell function assumes an
      # interactive environment, in particular to display messages or ask questions.
      # The rvm executable is more suitable for automated installs.
      #
      # use a ruby patch level known to have a binary
#      command => "${as_vagrant} '/home/vagrant/.rvm/bin/rvm install ruby-${ruby_version} --#binary --autolibs=enabled && rvm alias create default ${ruby_version}'",
#      creates => "/.rvm/bin/ruby",
#      require => Exec['install_rvm']
#    }

}

include must-have
