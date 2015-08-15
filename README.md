DrupalPro14 with Vagrant
===========

By wrapping the automations DrupalPro offers with the Vagrant enviroment, you can quickly create independent, sharable and disposable pre-configured development enviroment for drupal.

This is a vagrant project based on [DrupalPro14](https://github.com/jcmartinez/drupalpro14), which is derived from the QuickStrat and DrupalPro projects (see credits below).

#Prerequisites
I'm assuming you're familiar with Vagrant, if not going through their [Getting Started](http://docs.vagrantup.com/v2/getting-started/index.html) tutorial should be enough.

You can [istall Vagrant](https://www.vagrantup.com/downloads.html) on any OS.

#How to use

##1. Setup the Machine

    git clone https://github.com/IdanCo/drupalpro14.git c:\myproject
    cd c:\myproject
    vagrant up
    ... doing vagrant stuff ...
    vagrant reload

If it's you're first time, you'll have to wait for vagrant to download and install all the dependencies. The *reload* at the end is to make sure all changes were implemented. That's it!

##2. Creating your first drupal website

inside the project folder type 

    vagrant ssh

This will open an ssh connection with the machine. all tasks you're used to doing in the terminal will be done here.

    drush qc --domain=d7.dev

This will make the DrupalPro do its magic. When it's finished you'll have a complete drupal installation ready to go. to be able to access it throgh the host machine you'll have to add this line to you hosts file

    192.168.33.10 d71.dev

now you can access the newly created website by opening your browser and typing http://d7.dev . The source files awaits you inside the *websites* folder in you project's root.


# Customizations
drush help qc

If you want to destroy a site run the following:

drush qd --domain=d7.dev

#ToDos


#Credits

DrupalPro14 is based on the [Quickstart project](https://www.drupal.org/project/quickstart) and the [DrupalPro project](https://www.drupal.org/project/drupalpro), the first by [Michael Cole](https://www.drupal.org/u/michaelcole) and the later by [Mike Stewart](https://www.drupal.org/u/mike-stewart).
