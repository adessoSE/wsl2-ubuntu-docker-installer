#!/bin/bash
sudo apt-get update
# Prepare TLS encryption
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add and verify official Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -fsSL https://arkane-systems.github.io/wsl-transdebian/apt/wsl-transdebian.gpg | sudo apt-key add -


# Add apt repos
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo add-apt-repository \
   "deb [arch=amd64] https://arkane-systems.github.io/wsl-transdebian/apt \
   $(lsb_release -cs) \
   main"

wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update

sudo apt-get remove openssh-server multipath-tools

# Install Docker CE
sudo apt-get -y install docker-ce docker-ce.cli containerd.io systemd-genie

# Some cleanup for genie
sudo systemctl mask systemd-remount-fs.service

sudo usermod -aG docker $USER
