#!/bin/bash

###################################################################
# Preparing Ubuntu 14.04 for LAMP Dev
# THIS HAS SECURITY IMPLICATIONS:
# After this Ubuntu will not ask for password everytime you use sudo.
###################################################################

# This assumes that Ubuntu was installed using “drupalpro” as the user name.
WWWOwner="drupalpro" 

# Add current user to sudoers file - careful, this line could brick the box.
clear
sudo echo "$WWWOwner ALL=(ALL) NOPASSWD: ALL" | sudo tee -a "/etc/sudoers.d/$WWWOwner" > /dev/null

sudo chmod 0440 "/etc/sudoers.d/$WWWOwner"

# Add current user to root 'group' to make it easier to edit config files.
# THIS HAS SECURITY IMPLICATIONS
sudo adduser $WWWOwner root

