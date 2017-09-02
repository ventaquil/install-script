#!/bin/bash

# Install Docker
if [ "$(whereis docker | grep "/docker" | wc -l)" -eq "0" ]
then
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update -y
    sudo apt-get install -y docker-ce
    sudo systemctl enable docker
fi

# Print Docker version
docker -v

# Add current user in Docker group
if [ "$(id -nG $(whoami) | grep docker | wc -l)" -eq "0" ]
then
    sudo usermod -aG docker $(whoami)
fi

# Install Docker-Compose
if [ "$(whereis docker-compose | grep "/docker-compose" | wc -l)" -eq "0" ] || [ "$(docker-compose -v | awk -F ',' '{print $1}' | awk -F ' ' '{print $3}')" != "$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep $(echo "docker-compose-$(uname -s)-$(uname -m)") | cut -d '"' -f 4 | cut -c9- | awk -F '/' '{print $6}')" ]
then
   sudo curl -o /usr/local/bin/docker-compose -L $(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep $(echo "docker-compose-$(uname -s)-$(uname -m)") | cut -d '"' -f 4 | head -n 1)
   sudo chmod +x /usr/local/bin/docker-compose
fi

# Print Docker-Compose version
docker-compose -v

