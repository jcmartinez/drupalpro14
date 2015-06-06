#!/bin/bash

########################################################
# Remove Drupal non-development stuff from Ubuntu 14.04
# Run only if you want to reduce the size of your system
# or if you don't need this software.
########################################################

# SCRIPT VARIABLES
OPT_APTGET="-y"                     # APT-GET options

##
# UPDATE UBUNTU 14.04
sudo apt-get update
sudo apt-get $OPT_APTGET upgrade

# 0mb
sudo apt-get autoremove

# 305mb - Libre Office
sudo apt-get $OPT_APTGET purge libreoffice-gnome  libreoffice-draw  libreoffice-help-en-us  libreoffice-style-tango  libreoffice-impress  libreoffice-math  libreoffice-gtk  libreoffice-common  uno-libs3  python-uno  libreoffice-style-human  ure  libreoffice-base-core  libreoffice-calc  libreoffice-emailmerge  libreoffice-core libreoffice-writer

#  18mb - Games
sudo apt-get $OPT_APTGET purge aisleriot gnome-sudoku mahjongg gnomine

#   6mb - Bluetooth
sudo apt-get $OPT_APTGET purge bluez-alsa gir1.2-gnomebluetooth-1.0 bluez-gstreamer pulseaudio-module-bluetooth bluez-cups bluez gnome-bluetooth gnome-user-share

#  6.9mb - Shotwell photo manager
sudo apt-get $OPT_APTGET purge shotwell
#   6mb - Example videos and stuff
sudo apt-get $OPT_APTGET purge example-content
# rhythymbox
sudo apt-get $OPT_APTGET purge rhythmbox rhythmbox-data rhythmbox-plugin-magnatune gir1.2-rb-3.0 rhythmbox-mozilla rhythmbox-plugin-zeitgeist rhythmbox-plugin-cdrecorder rhythmbox-plugins

#   Unity media lens
sudo apt-get $OPT_APTGET purge unity-lens-video unity-scope-video-remote unity-scope-musicstores unity-lens-music

#   422k - Screen savers
sudo apt-get $OPT_APTGET purge gnome-screensaver
#  3.2mb - speech synthesis
sudo apt-get $OPT_APTGET purge espeak speech-dispatcher espeak-data libespeak1
#   1.7mb - Bittorrent client
sudo apt-get $OPT_APTGET purge transmission-common transmission-gtk
#   ubuntuone
sudo apt-get $OPT_APTGET remove --purge ubuntuone-*

#   remotedesktop
sudo apt-get $OPT_APTGET purge vino remmina-common remmina-plugin-rdp remmina-plugin-vnc remmina
#   Etc
sudo apt-get $OPT_APTGET purge usb-creator-gtk checkbox-gtk jockey-common jockey-gtk #computer-janitor-gtk

#  Async communications: microblog client, email client
sudo apt-get $OPT_APTGET purge empathy empathy-common nautilus-sendto-empathy telepathy-indicator folks-common telepathy-logger telepathy-gabble telepathy-haze telepathy-idle telepathy-salut telepathy-mission-control-5
sudo apt-get $OPT_APTGET purge thunderbird* pt-get evolution-common libevolution libfolks-eds25 empathy

# Realtime Communications: IM, VOIP, & IRC
sudo apt-get $OPT_APTGET purge gwibber gwibber-service libgwibber-gtk2 gwibber-service-identica gwibber-service-twitter gwibber-service-facebook libgwibber2

# User guide
sudo apt-get $OPT_APTGET purge gnome-user-guide ubuntu-docs

#  63mb - Printing
sudo apt-get $OPT_APTGET purge cups cups-bsd cups-client cups-common ghostscript ghostscript-x cups-driver-gutenprint python-cups system-config-printer-common system-config-printer-gnome system-config-printer-udev foomatic-db-engine foomatic-filters openprinting-ppds splix hplip-data hplip libcupsmime1 libgutenprint2 libcupsppdc1
# 15mb - Scanner drivers
sudo apt-get $OPT_APTGET purge sane-utils simple-scan libsane libsane-hpaio

sudo apt-get $OPT_APTGET purge thunderbird*

# remove packages that were automatically installed to satisfy dependencies for other packages and are now no longer needed.

sudo apt-get autoremove 

# clear out the local repository of retrieved package files. It removes everything but the lock file from /var/cache/apt/archives/ and /var/cache/apt/archives/partial/.

sudo apt-get clean

# Went too far and I removed the control center. Adding it back.
sudo apt-get $OPT_APTGET install gnome-control-center
sudo apt-get $OPT_APTGET install unity-control-center-signon
sudo apt-get $OPT_APTGET install libgnomekbd-common

# Tweak some annoyances

# Remove the shopping lens
sudo apt-get $OPT_APTGET purge unity-lens-shopping
sudo apt-get $OPT_APTGET purge unity-webapps-common

# Get back some decent scroll bars.
gsettings set com.canonical.desktop.interface scrollbar-mode normal

# Get back your menu bars.
sudo apt-get autoremove appmenu-gtk appmenu-gtk3 appmenu-qt

# Show username on panel.
gsettings set com.canonical.indicator.session show-real-name-on-panel true

# Install gnome flashback.
sudo apt-get $OPT_APTGET install gnome-session-flashback
sudo apt-get $OPT_APTGET install compizconfig-settings-manager
sudo apt-get $OPT_APTGET install indicator-applet-appmenu
sudo apt-get $OPT_APTGET install libgnomekbd-common

# Set a shortcut to Drupalpro14 Documentation

echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=firefox
Name[en_US]=DrupalPro14 Documentation
Comment[en_US]=Link to DrupalPro14 Documentation
Exec=firefox http://www.goingdrupal.com/drupalpro 
Name=Drupalpro14 Documentation
Comment=Link to Drupalpro14 Documentation
Icon=firefox
' >> '/home/drupalpro/Desktop/DrupalPro14.desktop'

sudo chmod +x /home/drupalpro/Desktop/DrupalPro14.desktop

sudo desktop-file-install /home/drupalpro/Desktop/DrupalPro14.desktop


