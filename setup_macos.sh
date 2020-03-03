#!/usr/bin/env bash
### Install Homebrew
/usr/bin/xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### Install Homebrew packages
/usr/local/bin/brew update
/usr/local/bin/brew install bash-completion
/usr/local/bin/brew install dark-mode
/usr/local/bin/brew install git
/usr/local/bin/brew install openssh
/usr/local/bin/brew install pkg-config
/usr/local/bin/brew install python
/usr/local/bin/brew install shadowsocks-libev
/usr/local/bin/brew install tree
/usr/local/bin/brew install vim

### Install Homebrew Taps
/usr/local/bin/brew tap homebrew/cask-versions
/usr/local/bin/brew tap homebrew/cask-fonts
/usr/local/bin/brew tap homebrew/services
/usr/local/bin/brew tap buo/cask-upgrade

### Install Homebrew Casks
mkdir -m 755 -v $HOME/Applications
/usr/local/bin/brew cask install alfred
/usr/local/bin/brew cask install appcleaner
/usr/local/bin/brew cask install docker-edge --appdir=$HOME/Applications
/usr/local/bin/brew cask install font-source-code-pro
/usr/local/bin/brew cask install iterm2 --appdir=$HOME/Applications
/usr/local/bin/brew cask install mactex-no-gui
/usr/local/bin/brew cask install the-unarchiver
/usr/local/bin/brew cask install vlc

### Trust any source
### Not recommended for macOS High Sierra and later
### Uncomment below if you want
#sudo /usr/sbin/spctl --master-disable
