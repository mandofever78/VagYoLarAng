A Vagrant-Yeoman-Laravel-Angular-Environment
==================

A Vagrant dev environment for Yeoman with Generator-Angular and Laravel built on an Ubuntu Precise32 12.04 Vagrant box provisioned with Puppet.


## Dependencies

1. [Vagrant](http://downloads.vagrantup.com/)
2. [VirtualBox (for local servers)](https://www.virtualbox.org/wiki/Downloads)

## Port Forwarding

22 => 2222 (ssh)
80 => 8888 (view dist after performing 'grunt')
3306 => 8889 (mysql)
9000 => 9000 (grunt serve)
35729 => 35729 (livereload)

## Usage

To create your local Yeoman environment:

        $ git clone https://github.com/mandofever78/vagrant-yeoman-env.git
        $ cd vagrant-yeoman-env/vagrant
        $ vagrant up
        $ Enter administrator password when prompted to enable NFS sharing
        
        
This will do the following

1. Download a Vagrant 'base box' for VirtualBox.  
2. Boot the VM and run Puppet to install additional dependencies:
    1. php
    2. composer
    3. apache
    4. git
    5. mysql
    6. phpmyadmin
    7. nodeJS
    8. bash
    9. curl
    9. fontconfig
    10. build-essential (compiler)
    11. wget
    12. PhantomJS
    13. Laravel
3. Then directories for Angular and Laravel are created for later scaffolding:
    1. /var/www/ang
    2. /var/www/laravel   
4. Then a few gems are installed:
    1. Compass
    2. SASS
5. Then some additional dependencies for Yeoman are installed via NPM
    1. Yo
    2. Generator-Angular
    3. Generator-Karma
6. Then Laravel is installed in /var/www/laravel 
7. Finally, apache is configured (and restarted) with the /puppet/template/vhost file to which also creates an alias for the laravel api backend routes reachable using "/lvl"


### Configure angular

Once everything is downloaded and puppet is done running, you can log in to the VM and start the server, then run these commands: ("front" is a custom alias pointing to the Angular application root[/var/www/angular]. Using "back" aliases to the Laravel root[/var/www/laravel].)

        $ vagrant ssh
        $ front
        $ yo angular //select desired options
        $ yo karma //for grunt testing
        $ npm install
        $ bower install
        
        Edit /var/www/angular/Gruntfile.js ~line 71 from 'localhost' to '0.0.0.0'
        
        
### View the Angular Project

        Run "grunt serve" to view (or 'gs')
        Run "grunt test" to test (or 'gt') //uses PhantomJS 
        Run "grunt" to build dist (or 'g')


Access the dev project on your host machine's browsers at http://0.0.0.0:9000

**SHORTCUTS:** 'gs', 'gt', and 'g' are custom bash aliases that first 'cd' into /var/www/angular then run 'grunt serve', 'grunt test', and 'grunt' respectively.

**GRUNT SERVE:** If you run into dependency problems, try deleting the /var/www/angular/node_modules folder and running "npm cache clear" followed by "npm install"

**GRUNT TEST/BUILD:** if you get karma:unit Task failures, make sure your /var/www/angular/test/karma.conf.js 'files' array contains these lines:

        '../bower_components/angular/angular.js',
        '../bower_components/angular-mocks/angular-mocks.js',
        '../bower_components/angular-resource/angular-resource.js',
        '../bower_components/angular-animate/angular-animate.js',
        '../bower_components/angular-touch/angular-touch.js',
        '../bower_components/angular-cookies/angular-cookies.js',
        '../bower_components/angular-sanitize/angular-sanitize.js',
        '../bower_components/angular-route/angular-route.js',
        '../app/scripts/*.js',
        '../app/scripts/**/*.js',
        'spec/**/*.js'
      
**NOTE:** Compressed, packaged assets can be found in ~/var/www/ang/dist and can be view by browsing to http://0.0.0.0:8888

### PHPmyAdmin

You can use PHPmyAdmin by browsing to http://0.0.0.0:8888/phpmyadmin


### Laravel

Public Laravel api routes that you create can be reached directly by the host browser at http://0.0.0.0:8888/lvl/(your-api-route). 

Use http://localhost:8888/lvl/(your-api-route) to connect the API routes in your Angular controllers during developement. DON'T FORGET TO REMOVE http://localhost:8888 FROM ANGULAR CONTROLLER API CALLS BEFORE USING 'GRUNT' TO BUILD, /lvl/(your-api-route) IS ALL THAT IS NEEDED FOR PRODUCTION.


    