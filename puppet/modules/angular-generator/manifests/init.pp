class angular-generator {


  file { "/var/www/ang":
      ensure => "directory",
      before => Exec['create angular site'],
      require => Package['generator-angular'],
  }

  exec { 'create angular site':
    command => '/usr/bin/yes | /usr/bin/yo angular',
    cwd => '/var/www/ang',
    require => File["/var/www/ang"],
    returns => [0, 8, 77],
  }

  file_line { "update hostname in gruntfile": 
    line => "\t\t\t\thostname: '0.0.0.0',", 
    path => "/var/www/ang/Gruntfile.js", 
    match => "hostname: '.*'", 
    ensure => present,
    require => Exec["create angular site"],
  }


}