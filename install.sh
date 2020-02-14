#!/usr/bin/env bash

os_type=`uname -s`
if [ "$os_type" = "Linux" ]; then
  os_type=`lsb_release -cs`
fi

printf "\e[32mInstalling bash configs for $os_type...\e[m\n"
install -m 644 -v $PWD/bash/bashrc.$os_type $HOME/.bashrc
install -m 644 -v $PWD/bash/bash_aliases.$os_type $HOME/.bash_aliases
printf "\e[32mBash configs installed, use 'source ~/.bashrc' to reload\e[m\n"

printf "\e[32mInstalling vim configs for $os_type...\e[m\n"
install -m 644 -v $PWD/vim/vimrc $HOME/.vimrc
printf "\e[32mVim configs installed\e[m\n"

printf "\e[32mInstalling git configs for $os_type...\e[m\n"
install -m 644 -v $PWD/git/gitconfig $HOME/.gitconfig
printf "\e[32mGit configs installed\e[m\n"

unset os_type
