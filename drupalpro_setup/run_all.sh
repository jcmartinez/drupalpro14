#!/bin/bash

bash 0-preparation.sh

bash 1-cleanup.sh

bash 2-install-lamp.sh

# no need in vagrant, mostly gui stuff
# bash 3-install-miscellaneous.sh

# if i wanted to use an IDE in my virtual box, i wouldn't use vagrant
# bash 4-install-netbeans.sh

bash 5-install-drush.sh
