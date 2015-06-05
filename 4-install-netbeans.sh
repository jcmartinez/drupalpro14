#!/bin/bash

##################################
# Install Netbeans in Ubuntu 14.04
##################################
set -e

sudo apt-get purge openjdk*
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version
wget http://dlc-cdn.sun.com/netbeans/8.0.2/final/bundles/netbeans-8.0.2-php-linux.sh
chmod +x netbeans-8.0.2-php-linux.sh
./netbeans-8.0.2-php-linux.sh

