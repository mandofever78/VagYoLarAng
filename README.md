VAgYoLarAng
==================

A vagrant dev environment for Yeoman with Angular and Laravel that uses a Ubuntu Precise32 12.04 Vagrant box and Puppet for provisioning.


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
3. Then directories for Angular and Laravel are created for later scaffolding:
    1. /var/www/ang
    2. /var/www/laravel   
4. Then a few gems are installed:
    1. Compass
    2. SASS
5. Then some additional dependencies for Yeoman are installed via NPM
    1. Yo
    2. Grunt
    3. Bower
    4. Phantomjs
    5. Yeoman Angular-generator
    6. Yeoman Karma-generator
6. Then a vanilla generator-angular site is scaffolded in /var/www/ang
7. Then Laravel is installed in /var/www/lvl 
8. Then, a small tweak is made to Gruntfile.js in the /ang/app directory that makes the angular instance available to the host machine when it is running
9. Finally, apache is configured (and restarted) with the /puppet/template/vhost file to which also creates an alias for the laravel api backend reachable through angular routes using "/lvl"


### Viewing the project

Once everything is downloaded and puppet is done running, you can log in to the VM and start the server

        $ vagrant ssh
        $ cd /var/www/ang
        $ yo karma
        $ bower update
        
        //Add these lines to karma.conf.js after angular.js include:
        
        'app/bower_components/angular-resource/angular-resource.js',
        'app/bower_components/angular-cookies/angular-cookies.js',
        'app/bower_components/angular-sanitize/angular-sanitize.js',
        'app/bower_components/angular-route/angular-route.js',
        
        //Then edit this line:
        'app/bower_components/angular/angular-mocks.js',
        //To this:
        'app/bower_components/angular-mocks/angular-mocks.js',
        
        //Change karma browser from "Chrome" to "PhantomJS" in karma.cong.js and karam-e2e.conf.js:
        
        browsers: ['PhantomJS'],
        
        //Finally, run bower update
        
        $ bower update 
        
        Run "grunt serve" to view or "grunt" to build dist
        
Then you can access the server on your host machine's browsers at http://0.0.0.0:9000

### PHPmyAdmin

You can use PHPmyAdmin by browsing to http://0.0.0.0:8888/phpmyadmin

### Testing

If you want to run unit tests on the project, ssh to the box, cd to ~/var/www/ang/app and run the following command

        $ grunt test
        
This will run your unit tests using the headless Webkit browser "Phantomjs"

### Packaging

If you want to package your project, ssh to the box, cd to ~/var/www/ang and run:

        $ grunt
        
Compressed, packaged assets can be found in ~/var/www/ang/dist and can be view by browsing to http://0.0.0.0:8888
        
## Notes


* Live refresh of the browser is not currently supported as the project server and your browser are running on different operating systems.

Happy Coding!

        
