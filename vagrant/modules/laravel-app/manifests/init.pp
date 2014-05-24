class laravel-app 
{
   	

	# Check to see if there's a composer.json and app directory before we delete everything
	# We need to clean the directory in case a .DS_STORE file or other junk pops up before
	# the composer create-project is called
	exec { 'clean lvl directory': 
		command => "/bin/sh -c 'cd /var/www/lvl && find -mindepth 1 -delete'",
		unless => [ "test -f /var/www//lvl/composer.json", "test -d /var/www/lvl/app" ],
		require => Package['apache2']
	}


	exec { 'create laravel project':
		command => "/bin/sh -c 'cd /var/www/lvl/ && composer create-project laravel/laravel . -n --prefer-dist'",
		require => [Class['composer::params'], Package['git-core'], Exec['clean lvl directory']],
		creates => "/var/www/lvl/composer.json",
		timeout => 1800,
	}

	exec { 'update packages':
        command => "/bin/sh -c 'cd /var/www/lvl/ && composer update'",
        require => [Package['git-core'], Package['php5'], Class['composer::params']],
        onlyif => [ "test -f /var/www/lvl/composer.json", "test -d /var/www/lvl/vendor" ],
        timeout => 900,
	}

	exec { 'install packages':
        command => "/bin/sh -c 'cd /var/www/lvl/ && composer install'",
        require => Package['git-core'],
        onlyif => [ "test -f /var/www/lvl/composer.json" ],
        creates => "/var/www/lvl/vendor/autoload.php",
        timeout => 900,
	}


	file { '/var/www/lvl/app/storage':
		mode => 0777
	}
}