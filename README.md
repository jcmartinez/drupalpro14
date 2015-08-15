DrupalPro14 with Vagrant
===========

By wrapping the automations DrupalPro offers with the Vagrant enviroment, you can quickly create independent, sharable and disposable pre-configured development enviroment for drupal.

This is a vagrant project based on [DrupalPro14](https://github.com/jcmartinez/drupalpro14), which is derived from the QuickStrat and DrupalPro projects (see credits below).

#Prerequisites
I'm assuming you're familiar with Vagrant, if not going through their [Getting Started](http://docs.vagrantup.com/v2/getting-started/index.html) tutorial should be enough.

You can [istall Vagrant](https://www.vagrantup.com/downloads.html) on any OS, but for this readme I'll assume you're using Windows.

[Having git](https://git-scm.com/) is not a must, but it would make you're life much easier.

#How to use

##1. Setup the Machine
if you're indeed using Windows, typing this would solve some line-ending issues -

    git config --global core.autocrlf input

and now you can type

    git clone https://github.com/IdanCo/drupalpro14.git c:\myproject
    cd c:\myproject
    vagrant up
    ... doing vagrant stuff ...
    vagrant reload

If it's you're first time, you'll have to wait for vagrant to download and install all the dependencies, and maybe approve some VirtualBox warnings. This could take some time. The *reload* at the end is to make sure all changes were implemented.

##2. Create your first drupal website

inside the project folder type 

    vagrant ssh

This will open an ssh connection with the machine. all tasks you're used to doing in the terminal will be done here.

    drush qc --domain=d7.dev

This will make the DrupalPro do its magic. When it's finished you'll have a complete drupal installation ready to go. to be able to access it throgh the host machine you'll have to add this line to you hosts file

    192.168.33.10 d71.dev

now you can access the newly created website by opening your browser and typing http://d7.dev. btw, this ip is configurable through the *vagrantfile* in your project's root.
## 3. Develop!

Open your favourite IDE and point it at your source files, which awaits inside the *websites* folder of your project's root.

#Working with vagrant
##1. Basic Actions
stop the machine, when you're finished working for today:

    vagrant halt

start the machine, when you want to start working again:

    vagrant up

restart the machine, just for that fresh post-boot smell:

    vagrant reload

destroy the machine, when the project is over, or when you really need to start over:

    vagrant destroy
btw, even after destorying the machine you can create a new one simply by typing *vagrant up* again.

##2. Sharing
vagrant lets you easily share you're work with others by typing

    vagrant share
TODO: how to share specific url and not just the whole machine

## 3. Debuging
TODO


# Working with DrupalPro
## 1. Create Multiple Websites
you can create more website simply by connecting to your machine (*vagrant ssh*) and typing

    drush qc --domain=mywebsite.dev

don't forget to add the new record to your hosts file -

    192.168.33.10 mywebsite.dev

## 2. Use Different Drupal Versions
to create a drupal 6 site -

    drush qc --domain=d6.dev --makefile=d6.make

to create a drupal 8 site -

    drush qc --domain=d8.dev --makefile=d8.make

more wonders -

    drush help qc

## 3. Destroy a Website
If you want to destroy a site run the following:

    drush qd --domain=d7.dev


# Passwords
**ubuntu**: vagrant/vagrant
**mysql**: root/vagrant 
**drupal**: admin/admin

#ToDos

there are some non-critical errors when running the scripts. it would be nice to get rid of them.

#Credits

DrupalPro14 is based on the [Quickstart project](https://www.drupal.org/project/quickstart) and the [DrupalPro project](https://www.drupal.org/project/drupalpro), the first by [Michael Cole](https://www.drupal.org/u/michaelcole) and the later by [Mike Stewart](https://www.drupal.org/u/mike-stewart).
