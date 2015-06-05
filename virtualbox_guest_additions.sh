#!/bin/bash

# Use this only if you are installing Drupalpro in a Virtualbox machine.
# This will install virtualbox Gest additions.
# See: http://askubuntu.com/questions/588943/experiencing-small-resolution-issue-in-ubuntu-14-04-2-with-virtualbox-getting-s

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get instal dkms -y
sudo apt-get remove libcheese-gtk23 -y
sudo apt-get install xserver-xorg-core -y
sudo apt-get install -f virtualbox-guest-x11 -y
sudo reboot now

