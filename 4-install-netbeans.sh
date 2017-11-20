#!/bin/bash

##################################
# Install Netbeans in Ubuntu 14.04
##################################

# SCRIPT VARIABLES
OPT_APTGET="-y"                     # APT-GET options

sudo apt-get purge openjdk*
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get $OPT_APTGET install oracle-java8-installer
java -version

ARCH=$(uname -m)
if [ "$ARCH" != "x86_64" ]
then
   echo "Unsupported architecture: $ARCH"
   echo "DrupalPro14 only supports x86_64 for now."
else
   wget http://dlc-cdn.sun.com/netbeans/8.2/final/bundles/netbeans-8.2-php-linux-x64.sh
   chmod +x netbeans-8.2-php-linux-x64.sh
   ./netbeans-8.2-php-linux-x64.sh
fi

