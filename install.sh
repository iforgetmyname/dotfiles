#!/usr/bin/env bash

os_type=`uname -s`
if [ "$os_type" = "Linux" ]; then
  os_type=`lsb_release -cs`
fi

printf "\e[32mInstalling bash configs for $os_type...\e[m\n"
install -m 644 -v $PWD/bash/bashrc.$os_type $HOME/.bashrc
install -m 644 -v $PWD/bash/bash_aliases.$os_type $HOME/.bash_aliases
printf "\e[32mBash configs installed, use 'source ~/.bashrc' to reload\e[m\n"

printf "\e[32mInstalling vim configs...\e[m\n"
install -m 644 -v $PWD/vim/vimrc $HOME/.vimrc
printf "\e[32mVim configs installed\e[m\n"

printf "\e[32mInstalling git configs...\e[m\n"
install -m 644 -v $PWD/git/gitconfig $HOME/.gitconfig
printf "\e[32mGit configs installed\e[m\n"

printf "\e[32mInstalling vscode configs for $os_type...\e[m\n"
if [ "$os_type" = "Darwin" ]; then
  if [ -e $HOME/Library/ApplicationSupport/Code/User/settings.json ]; then
    install -m 644 -v $PWD/vscode/settings.json $HOME/Library/ApplicationSupport/Code/User/settings.json
    printf "\e[32mVscode configs installed\e[m\n"
  else
    printf "\e[93mVscode not installed\e[m\n"
  fi
elif [ `uname -s` = "Linux" ]; then
  if [ -e $HOME/.config/Code/User/settings.json ]; then
    install -m 644 -v $PWD/vscode/settings.json $HOME/.config/Code/User/settings.json
    printf "\e[32mVscode configs installed\e[m\n"
  else
    printf "\e[93mVscode not installed\e[m\n"
  fi
else
  printf "\e[31m$os_type not supported for vscode\e[m\n"
fi

unset os_type
