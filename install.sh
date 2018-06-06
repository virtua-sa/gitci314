#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get install -y \
    git \
    pv \
    screen

# Install Docker
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi
sudo apt-get install -y docker-compose

# Clone Gitci314 repository
git clone https://github.com/virtua-sa/gitci314.git 
cd gitci314

# Increase swap size to 4GB
# SWAP may reduce dramatically the lifespan of your RPi SD Card
# So we highly recommend to move following file on a USB drive
# Path of the swap file:
${SWAPFILE}=${SWAPFILE:-/var/swap}
# Size of the swap file, in GiB:
${SWAPSIZE}=${SWAPSIZE:-4}
sudo dphys-swapfile swapoff
free -m
sudo sed -i "s/CONF_SWAPSIZE/CONF_SWAPSIZE=$((SWAPSIZE*1024))/g" /etc/dphys-swapfile
sudo sed -i "s/CONF_SWAPFILE/CONF_SWAPFILE=${SWAPFILE}/g" /etc/dphys-swapfile
sudo dd if=/dev/zero | pv -s ${SWAPSIZE}G | sudo dd of=${SWAPFILE} bs=1024 count=$((SWAPSIZE*1024*1024))
sudo chown root:root ${SWAPFILE}
sudo chmod 0600 ${SWAPFILE}
sudo mkswap ${SWAPFILE}
sudo dphis-swapfile swapon
free -m

# Change Raspberry Pi SSH port from 22 to 2022
# (to be able to use Git over SSH on default port)
sed -i 's/^Port .*/Port 2022/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

# Run Gitci314 !
screen docker-compose up -d