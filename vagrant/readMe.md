RUN THESE COMMANDS AFTER 'VAGRANT UP'

    vagrant ssh

    cd /var/www/ang

    npm install

    bower update

    npm install karma-jasmine --save-dev

    npm install karma-PhantomJS-launcher --save-dev

edit gruntfile.js
change localhost to 0.0.0.0
 
edit karma.conf
change karma.conf from chrome to phantomjs