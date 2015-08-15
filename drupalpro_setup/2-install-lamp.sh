#!/bin/bash

##############################
# Install LAMP on Ubuntu 14.04
##############################

# SCRIPT VARIABLES
WWWOwner="drupalpro"                # user
WWWGroup="www-data"                 # apache group
DIRHome="/home/$WWWOwner"           # user home path
DIRwww="$DIRHome/websites"          # path to website projects directory
VER_GEANY_SCHEMES="1.22"            # Version of colorschemes for geany
OPT_APTGET="-y"                     # APT-GET options

#======================================| PATHS
WWW_ROOT="${HOME}/websites"         # Fullpath to where websites will be installed
LOGS="${WWW_ROOT}/logs"   	        # Fullpath to where symlink to LAMP logfiles will be stored
CONFIGS="${WWW_ROOT}/config"        # Fullpath to where symlink to LAMP config will be stored

# CORE INSTALL
# note: you'll need to enter a root password for mysql
sudo apt-get $OPT_APTGET install apache2 php5 php5-dev php-pear libapache2-mod-php5 php5-mysql php5-sqlite php5-intl php5-cli php5-xdebug php5-gd mariadb-server-5.5

## config php apache DEV

php_ini="/etc/php5/apache2/php.ini"

if [ ! -f $php_ini".bak" ]
then
sudo cp $php_ini $php_ini".bak"
fi

## Configure PHP
# sudo sed -i 's/find_this/replace_with_this/g' infile1 infile2 etc
sudo sed -i 's/short_open_tag = On/short_open_tag = Off/g' $php_ini
sudo sed -i 's/memory_limit = .*/memory_limit = 512M/g' $php_ini
sudo sed -i 's/error_reporting = .*/error_reporting = E_ALL | E_STRICT/g' $php_ini
sudo sed -i 's/display_errors = Off/display_errors = On/g' $php_ini
sudo sed -i 's/html_errors = Off/html_errors = On/g' $php_ini
sudo sed -i 's/magic_quotes_gpc = On/magic_quotes_gpc = Off/g' $php_ini
sudo sed -i 's/max_execution_time = 30/max_execution_time = 300/g' $php_ini
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' $php_ini
sudo sed -i 's/post_max_size = 8M/post_max_size = 50M/g' $php_ini
sudo sed -i 's/display_startup_errors = Off/display_startup_errors = On/g' $php_ini
sudo sed -i 's/expose_php = On/expose_php = Off/g' $php_ini
sudo sed -i 's/allow_url_fopen = On/allow_url_fopen = Off/g' $php_ini

# Install upload progress (warning in D7)
sudo pecl -q install uploadprogress
echo "extension=uploadprogress.so" | sudo tee /etc/php5/mods-available/uploadprogress.ini > /dev/null
sudo php5enmod uploadprogress

if ! grep -xq "\[xdebug\]" $php_ini
then
sudo tee -a $php_ini <<XDEBUG
[xdebug]
xdebug.remote_enable=On
xdebug.remote_connect_back=On
xdebug.remote_handler=dbgp
xdebug.remote_mode=req
xdebug.remote_host=10.0.0.1
xdebug.remote_port=9000
xdebug.max_nesting_level=256
XDEBUG

fi

## Configure APACHE

# Replace default config file with optimized version from
# https://github.com/gregrickaby/The-Perfect-Apache-Configuration.git
#
# Commented out because it failed to restart apache. Needs a fix.
#
#git clone https://github.com/gregrickaby/The-Perfect-Apache-Configuration.git perfect_apache_config
#sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.original
#sudo mv perfect_apache_config/http.conf /etc/apache2/apache2.conf
#sudo chown root:root /etc/apache2/apache2.conf
#sudo rm -rf perfect_apache_config

# Stops Apache complaining about not knowing the FQDN
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
sudo a2enconf fqdn.conf
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2dismod cgi
sudo a2dismod autoindex

sudo service apache2 restart

## config php cli DEV

php_ini="/etc/php5/cli/php.ini"

if [ ! -f $php_ini".bak" ]
then
sudo cp $php_ini $php_ini".bak"
fi

sudo sed -i 's/short_open_tag = On/short_open_tag = Off/g' $php_ini
sudo sed -i 's/memory_limit = \d{1-3}M/memory_limit = -1/g' $php_ini
sudo sed -i 's/error_reporting = .*/error_reporting = E_ALL | E_STRICT/g' $php_ini
sudo sed -i 's/display_errors = Off/display_errors = On/g' $php_ini
sudo sed -i 's/html_errors = Off/html_errors = On/g' $php_ini

# Fix comment bug that will show warning on command line
sudo sed -i 's/# /\/\/ /g'        	/etc/php5/cli/conf.d/mcrypt.ini
sudo sed -i 's/# /\/\/ /g'        	/etc/php5/cli/conf.d/imap.ini

#======================================| Log Files
mkdir -p "${LOGS}"

# Create symlink to Apache log directory.
ln -s      	/var/log/apache2  "${LOGS}/apache-access-log"

# php error logs are configured in php.ini.
sudo touch 	/var/log/php-error.log
sudo chmod g+w /var/log/php-error.log
ln -s      	/var/log/php-error.log                	"${LOGS}/php-error.log"

# MySQL error and slow query logs.
sudo touch 	/var/log/mysql/error.log
sudo chmod g+w /var/log/mysql/error.log
ln -s      	/var/log/mysql/error.log              	"${LOGS}/mysql-error.log"
sudo touch 	/var/log/mysql/mysql-slow.log
sudo chmod g+w /var/log/mysql/mysql-slow.log
ln -s      	/var/log/mysql/mysql-slow.log         	"${LOGS}/mysql-slow.log"


#======================================| Config Files
mkdir -p "${CONFIGS}"
sudo chmod -R g+w /etc/apache2
ln -s /etc/apache2/apache2.conf  	"${CONFIGS}/apache2.conf"
ln -s /etc/apache2/httpd.conf    	"${CONFIGS}/httpd.conf"
ln -s /etc/apache2/ports.conf    	"${CONFIGS}/ports.conf"
ln -s /etc/apache2/sites-enabled/	"${CONFIGS}/apache-sites-enabled"
sudo chmod -R g+w /etc/php5
ln -s /etc/php5/apache2/php.ini  	"${CONFIGS}/php-apache.ini"
ln -s /etc/php5/cli/php.ini      	"${CONFIGS}/php-cli.ini"
sudo chmod -R g+w /etc/mysql
ln -s /etc/mysql/my.cnf          	"${CONFIGS}/mysql.cnf"
sudo chmod g+w /etc/hosts
ln -s /etc/hosts                 	"${CONFIGS}/hosts"

echo "This folder contains links (shortcuts) to LAMP configuration files.  This was
created to make it easier for new users to find logs. However, all Ubuntu/Debian
servers (and other flavors of linux) store configuration in the /etc/ folder.

To see the links, and the path to the config files, open a terminal (F4) & type:

ll

This will list the files and where they link to." > "${CONFIGS}/README.txt"

# Setup websites directory
sudo -u $WWWOwner -g $WWWGroup mkdir -p $DIRwww
sudo chown -R $WWWOwner:$WWWGroup $DIRwww
sudo chmod -R 2775 $DIRwww
sudo chmod g+s $DIRwww

# Install Desktop development apps
sudo apt-get $OPT_APTGET install gitg meld nautilus-compare guake geany diodon synaptic indicator-multiload gksu

# Setup GEANY
[ ! -d $DIRHome/.config/geany ] && sudo -u $WWWOwner -g $WWWOwner mkdir -p $DIRHome/.config/geany
sudo -u $WWWOwner -g $WWWOwner git clone https://github.com/codebrainz/geany-themes.git $DIRHome/.config/geany/codebrainz
cd $DIRHome/.config/geany/codebrainz
git checkout tags/$VER_GEANY_SCHEMES
sudo -u $WWWOwner -g $WWWOwner mkdir -p $DIRHome/.config/geany/colorschemes
sudo -u $WWWOwner -g $WWWOwner ln -s $DIRHome/.config/geany/codebrainz/colorschemes/* $DIRHome/.config/geany/colorschemes/

# Install Filezilla
sudo apt-get $OPT_APTGET install filezilla

