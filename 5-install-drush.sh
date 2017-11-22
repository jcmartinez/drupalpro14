#!/bin/bash

###############################
# Install Drush on Ubuntu 14.04
###############################

# SCRIPT VARIABLES
OPT_APTGET="-y"                     # APT-GET options

# Install Drush.
# Ensure the Curl dependency is installed.
sudo apt-get $OPT_APTGET install curl

# Download the Composer installer and pass it to php.
sudo curl -sS https://getcomposer.org/installer | php

# Place the composer executable in a directory included in the system PATH.
sudo mv composer.phar /usr/local/bin/composer

composer --version

# Install a default version of Drush globally.
composer global require drush/drush:7.*

# Add Composer Global Bin to PATH.
FILE=$HOME/.bashrc
if [ -f $FILE ];
then
   sed -i "1i export PATH=\"$(composer config -g home 2>/dev/null)/vendor/bin:\$PATH\"" $HOME/.bashrc
else
   echo "export PATH=\"$(composer config -g home 2>/dev/null)/vendor/bin:\$PATH\"" >> $HOME/.bashrc
fi
source $HOME/.bashrc

drush --version

# Install Drush addons.
sudo mkdir -p /usr/share/drush/commands/
sudo mv drush_addons/make_templates ~/make_templates
sudo mv drush_addons /usr/share/drush/commands/quickstart
drush cc drush

# Install Drush 8.
mkdir ~/drush8
cd ~/drush8
composer require drush/drush:8.*

ln -sf ~/drush8/vendor/bin/drush $(composer config -g home 2>/dev/null)/vendor/bin/drush8

drush8 --version

drush8 cc drush

#reboot
sudo apt-get $OPT_APTGET autoremove
sudo reboot now

