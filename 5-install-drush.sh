#!/bin/bash

###############################
# Install Drush on Ubuntu 14.04
###############################

set -e  # Stop in case of error.

# Install Drush.
# Ensure the Curl dependency is installed.
sudo apt-get -y install curl

# Download the Composer installer and pass it to php.
sudo curl -sS https://getcomposer.org/installer | php

# Place the composer executable in a directory included in the system PATH.
sudo mv composer.phar /usr/local/bin/composer

composer --version

# Add drush.
composer global require drush/drush:dev-master

# Add Drush to your system path.
sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc
source $HOME/.bashrc

drush --version

# Install Drush addons.
sudo mkdir -p /usr/share/drush/commands/
sudo mv drush_addons/make_templates ~/make_templates
sudo mv drush_addons /usr/share/drush/commands/quickstart
drush cc drush

#reboot
sudo reboot now

