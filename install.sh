#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get install -y \
    git \
    screen

# Install Docker
curl -sSL https://get.docker.com | sh

# Clone Gitci314 repository
git clone https://github.com/virtua-sa/gitci314.git 
cd gitci314

# Run Gitci314 !
screen docker-compose up -d