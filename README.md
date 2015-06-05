DrupalPro14
===========

This is a collection of shell script that can be run in a clean installation of Ubuntu 14.04 (64bits) desktop edition in order to build a Drupal development environment similar to the pre-configured development environment that was offered for download as a VirtualBox image for Ubuntu 12.04 (32bit).

This work is derived from the QuickStrat and DrupalPro projects (see credits below).

This code has been tested in a VirtualBox machine but should work in a physical machine after applying some security hardening to the system.

#How to use

##Install Ubuntu

Install Ubuntu 14.04 (64bits) Desktop Edition on your computer.

IMPORTANT: During the installation you will be asked to create a user account. Make sure that the username for this account is: drupalpro

Once the installation is done login to your new system using your "drupalpro" account and the password that you selected.

##Update Ubuntu for the first time

Open the terminal by pressing Ctrl+Alt+t and type the following two commands:

sudo apt-get update

sudo apt-get upgrade

##Retrieve this code using Git

###Install Git

In the terminal type:

sudo apt-get install git

###Retrieve this code

In the terminal type:

git clone https://github.com/jcmartinez/drupalpro14.git ~/drupalpro_install

##Run the configuration scripts

In the terminal navigate to the directory where you just downloaded the installation scripts:

cd drupalpro_install

...and run the scripts as follows:

sudo bash 0-preparation.sh

sudo bash 1-cleanup.sh

sudo bash 2-install-lamp.sh

sudo bash 3-install-miscellaneous.sh

sudo bash 4-install-netbeans.sh

sudo bash 5-install-drush.sh

##Create your first Drupal site

In your terminal navigate to the "websites" directory:

cd ~/websites

... and run the following command to install a Website:

drush qc all --domain=d7.dev --codepath=/home/drupalpro/websites/d7.dev --makefile=/home/drupalpro/make_templates/d7.make --profile=standard

Now you should be able to visit your website using a browser and typing http://d7.dev in the address bar.

If you want to install another site use the same command above and modify the variables --domain and --codepath.

#ToDos

So far only one IDE environment (Netbeans) has been installed. If you know how to script the installation of other environments please fork this code and it will be added.

#Credits

DrupalPro14 is based on the Quickstart project (https://www.drupal.org/project/quickstart) and the DrupalPro project (https://www.drupal.org/project/drupalpro), the first by Michael Cole (https://www.drupal.org/u/michaelcole) and the later by Mike Stewart (https://www.drupal.org/u/mike-stewart).
