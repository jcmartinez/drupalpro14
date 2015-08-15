#!/bin/bash

###########################################
# Additional configurations on Ubuntu 14.04
###########################################

# SCRIPT VARIABLES
OPT_APTGET="-y"                     # APT-GET options

# Install a gui for the firewall
sudo apt-get $OPT_APTGET install gufw

# Install compression tools
sudo apt-get $OPT_APTGET install p7zip-rar p7zip-full unrar zip unzip rar

#Change Defaults for guake
echo "Configuring guake"
gconftool -s /apps/guake/keybindings/global/show_hide --type=string "F4"  	# Change to F4 since F12 means firebug/dev utilities in most browsers
gconftool -s /apps/guake/general/history_size --type=int 8192             	# more history
gconftool -s /apps/guake/style/background/transparency --type=int 10      	# Easier to see
gconftool -s /apps/guake/general/window_ontop --type=bool false           	# Alow dialog pop-ups to take focus
gconftool -s /apps/guake/style/font/style --type=string "Monospace 13"    	# Easier to see
# Set Guake to start on boot time
sudo cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

#======================================| configure GIT Tools
# mostly based off http://cheat.errtheblog.com/s/git
echo "Configuring Git"
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.df diff
git config --global alias.lg "log --graph --pretty=format:'%C(blue)%h %Creset%C(reverse bold blue)%d%Creset %C(white)%s %C(green bold)%cr%Creset %C(green)%aN' --abbrev-commit --decorate"
git config --global alias.clear '!git add -A && git reset --hard'
git config --global alias.unstage "reset HEAD --"
git config --global alias.ign "ls-files -o -i --exclude-standard"
git config --global alias.gitkconflict '!gitk --left-right HEAD...MERGE_HEAD'
git config --global alias.alias "config --get-regexp alias"
git config --global apply.whitespace error-all
git config --global color.ui auto
git config --global color.diff.whitespace "red reverse"
git config --global color.diff.meta "magenta"
git config --global color.diff.frag "yellow"
git config --global color.diff.old "red"
git config --global color.diff.new "green bold"
git config --global color.grep.context yellow
git config --global color.grep.filename blue
git config --global color.grep.function "yellow bold"
git config --global color.grep.linenumber "cyan bold"
git config --global color.grep.match red bold
git config --global color.grep.selected white
git config --global color.grep.separator blue
git config --global color.status.added yellow
git config --global color.status.changed red
git config --global color.status.untracked "cyan bold"
git config --global diff.tool meld
git config --global gui.editor geany
git config --global instaweb.httpd 'apache2'
git config --global merge.summary true
git config --global merge.tool meld

