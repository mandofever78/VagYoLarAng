class laravel-app 
{
   	

	# Check to see if there's a composer.json and app directory before we delete everything
	# We need to clean the directory in case a .DS_STORE file or other junk pops up before
	# the composer create-project is called
	

	exec { 'create laravel project':
		command => "/bin/sh -c 'cd /var/www/ && composer create-project laravel/laravel  --prefer-dist'",
		require => [Class['composer::params'], Package['git-core']],
		creates => "/var/www/laravel/composer.json",
		timeout => 1800,
	}

	exec { 'update packages':
        command => "/bin/sh -c 'cd /var/www/laravel/ && composer update'",
        require => [Package['git-core'], Package['php5'], Class['composer::params']],
        onlyif => [ "test -f /var/www/laravel/composer.json", "test -d /var/www/laravel/vendor" ],
        timeout => 900,
	}

	exec { 'install packages':
        command => "/bin/sh -c 'cd /var/www/laravel/ && composer install'",
        require => Package['git-core'],
        onlyif => [ "test -f /var/www/laravel/composer.json" ],
        creates => "/var/www/laravel/vendor/autoload.php",
        timeout => 900,
	}


	file { '/var/www/laravel/app/storage':
		mode => 0777
	}
}