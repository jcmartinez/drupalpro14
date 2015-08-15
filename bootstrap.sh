#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade

# if we had this machine before, let's clean the slate
if [ -d "$HOME/websites/config" ]; then
	rm -r $HOME/websites/*
fi

cd $HOME/drupalpro_setup
bash run_all.sh