#!/usr/bin/env bash

os_type=`uname -s`
if [ "$os_type" = "Linux" ]; then
  os_type=`lsb_release -cs`
fi
printf "Installing bash configs for $os_type...\n\n"

install -m 644 -v $PWD/bash/bashrc.$os_type $HOME/.bashrc
install -m 644 -v $PWD/bash/bash_aliases.$os_type $HOME/.bash_aliases

printf "\nBash configs installed, use 'source ~/.bashrc' to reload\n"

unset os_type
