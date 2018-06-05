#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get install -y \
    git \
    screen

# Install Docker
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi
sudo apt-get install -y docker-compose

# Clone Gitci314 repository
git clone https://github.com/virtua-sa/gitci314.git 
cd gitci314

# Change Raspberry Pi SSH port from 22 to 2022
# (to be able to use Git over SSH on default port)
sed -i 's/^Port .*/Port 2022/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

# Run Gitci314 !
screen docker-compose up -d