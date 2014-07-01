#!/bin/bash

echo -n "Begin Bash Profile setup: "

bash_profile="/home/vagrant/.bash_profile"

if [[ -e "$bash_profile" ]]; then
	cp "$bash_profile" "${bash_profile}.bak"
fi


echo "# Regular Colors" > /home/vagrant/.bash_profile
echo "Black='\e[0;30m'        # Black" >> /home/vagrant/.bash_profile
echo "Red='\e[0;31m'          # Red" >> /home/vagrant/.bash_profile
echo "Green='\e[0;32m'        # Green" >> /home/vagrant/.bash_profile
echo "Yellow='\e[0;33m'       # Yellow" >> /home/vagrant/.bash_profile
echo "Blue='\e[0;34m'         # Blue" >> /home/vagrant/.bash_profile
echo "Purple='\e[0;35m'       # Purple" >> /home/vagrant/.bash_profile
echo "Cyan='\e[0;36m'         # Cyan" >> /home/vagrant/.bash_profile
echo "White='\e[0;37m'        # White" >> /home/vagrant/.bash_profile
echo "# Bold" >> /home/vagrant/.bash_profile
echo "BBlack='\e[1;30m'       # Black" >> /home/vagrant/.bash_profile
echo "BRed='\e[1;31m'         # Red" >> /home/vagrant/.bash_profile
echo "BGreen='\e[1;32m'       # Green" >> /home/vagrant/.bash_profile
echo "BYellow='\e[1;33m'      # Yellow" >> /home/vagrant/.bash_profile
echo "BBlue='\e[1;34m'        # Blue" >> /home/vagrant/.bash_profile
echo "BPurple='\e[1;35m'      # Purple" >> /home/vagrant/.bash_profile
echo "BCyan='\e[1;36m'        # Cyan" >> /home/vagrant/.bash_profile
echo "BWhite='\e[1;37m'       # White" >> /home/vagrant/.bash_profile

echo "# Underline" >> /home/vagrant/.bash_profile
echo "UBlack='\e[4;30m'       # Black" >> /home/vagrant/.bash_profile
echo "URed='\e[4;31m'         # Red" >> /home/vagrant/.bash_profile
echo "UGreen='\e[4;32m'       # Green" >> /home/vagrant/.bash_profile
echo "UYellow='\e[4;33m'      # Yellow" >> /home/vagrant/.bash_profile
echo "UBlue='\e[4;34m'        # Blue" >> /home/vagrant/.bash_profile
echo "UPurple='\e[4;35m'      # Purple" >> /home/vagrant/.bash_profile
echo "UCyan='\e[4;36m'        # Cyan" >> /home/vagrant/.bash_profile
echo "UWhite='\e[4;37m'       # White" >> /home/vagrant/.bash_profile

echo "# Bold High Intensity" >> /home/vagrant/.bash_profile
echo "BIWhite='\e[1;97m'      # White" >> /home/vagrant/.bash_profile
echo "BIGreen='\e[1;92m'      # Green" >> /home/vagrant/.bash_profile

echo "bakblk='\e[40m'   # Black - Background" >> /home/vagrant/.bash_profile
echo "txtrst='\e[0m'    # Text Reset" >> /home/vagrant/.bash_profile

echo "# Get the aliases and functions" >> /home/vagrant/.bash_profile
echo "if [ -f ~/.bashrc ]; then" >> /home/vagrant/.bash_profile
echo "    . ~/.bashrc" >> /home/vagrant/.bash_profile
echo "fi" >> /home/vagrant/.bash_profile


echo "#   Change Prompt" >> /home/vagrant/.bash_profile
echo "#   ------------------------------------------------------------" >> /home/vagrant/.bash_profile
echo '    export PS1="________________________________________________________________________________\n|\[$Red\] \w \[$Black\]@ \[$Green\]\h - \[$BIWhite\]\[$bakblk\]\u\[$txtrst\] \n| \$ "' >> /home/vagrant/.bash_profile
echo '    export PS2="| \$ "' >> /home/vagrant/.bash_profile


echo "Finished Bash Profile Setup"



echo -n "Begin Bash Aliases Setup: "

bash_aliases="/home/vagrant/.bash_aliases"

if [[ -e "$bash_aliases" ]]; then
	cp "$bash_aliases" "${bash_aliases}.bak"
fi

echo 'alias front="cd /var/www/angular"' > /home/vagrant/.bash_aliases
echo 'alias back="cd /var/www/laravel"' >> /home/vagrant/.bash_aliases
echo 'alias gs="cd /var/www/angular && grunt serve"' >> /home/vagrant/.bash_aliases
echo 'alias gt="cd /var/www/angular && grunt test"' >> /home/vagrant/.bash_aliases
echo 'alias g="cd /var/www/angular && grunt"' >> /home/vagrant/.bash_aliases
echo 'alias edit="sudo nano"' >> /home/vagrant/.bash_aliases
echo "alias cp='cp -iv'                           # Preferred 'cp' implementation" >> /home/vagrant/.bash_aliases
echo "alias mv='mv -iv'                           # Preferred 'mv' implementation" >> /home/vagrant/.bash_aliases
echo "alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation" >> /home/vagrant/.bash_aliases
echo "alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation" >> /home/vagrant/.bash_aliases
echo "alias less='less -FSRXc'                    # Preferred 'less' implementation" >> /home/vagrant/.bash_aliases
echo 'cd() { builtin cd "$@"; ll; }               # Always list directory contents upon cd' >> /home/vagrant/.bash_aliases
echo "alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)" >> /home/vagrant/.bash_aliases
echo "alias ..='cd ../'                           # Go back 1 directory level" >> /home/vagrant/.bash_aliases
echo "alias ...='cd ../../'                       # Go back 2 directory levels" >> /home/vagrant/.bash_aliases
echo "alias .3='cd ../../../'                     # Go back 3 directory levels" >> /home/vagrant/.bash_aliases
echo "alias .4='cd ../../../../'                  # Go back 4 directory levels" >> /home/vagrant/.bash_aliases


echo "Finished Bash Aliases Setup"
