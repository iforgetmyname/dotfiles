#!/usr/bin/env bash
/usr/bin/xcode-select --install
/usr/sbin/softwareupdate --install-rosetta

printf "Please manually download MacPorts in the following link:\n"
/usr/bin/open https://github.com/macports/macports-base/releases/
/usr/bin/read -p "Press enter to continue"

sudo /opt/local/bin/port selfupdate
sudo /opt/local/bin/port -N install bash bash-completion vim git wget curl tree openssh podman
sudo /opt/local/bin/port -N install python38 py38-pip py38-setuptools py38-autopep8 py38-codestyle
sudo /opt/local/bin/port -N install python39 py39-pip py39-setuptools py39-autopep8 py39-codestyle
sudo /opt/local/bin/port -N install python310 py310-pip py310-setuptools py310-autopep8 py310-codestyle

sudo /opt/local/bin/port select --set python python310
sudo /opt/local/bin/port select --set python3 python310
sudo /opt/local/bin/port select --set pip pip310
sudo /opt/local/bin/port select --set pip3 pip310
sudo /opt/local/bin/port select --set autopep8 autopep8-310
sudo /opt/local/bin/port select --set pycodestyle pycodestyle-py310
