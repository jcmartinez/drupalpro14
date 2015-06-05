#!/bin/bash

##########################
# Install Drush on Ubuntu 14.04
##########################

set -e  # Stop in case of error.

# Install Drush.
# Ensure the Curl dependency is installed.
sudo apt-get -y install curl
# Download the Composer installer and pass it to php.
sudo curl -sS https://getcomposer.org/installer | php
# Place the composer executable in a directory included in the system PATH.
sudo mv composer.phar /usr/local/bin/composer
# Add drush.
composer global require drush/drush:7.*
# Make sure Composer's global bin directory is on the system PATH.
sudo sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc
source $HOME/.bashrc

# Install Drush addons.
# Quickstart drush addons install
git clone --branch 7.x-3.x https://github.com/KLicheR/drupalpro.git

sudo mv drupalpro/drush_addons/quickstart /usr/share/drush/commands/quickstart
mv drupalpro/drush_addons/make_templates ~/make_templates
drush cc drush
