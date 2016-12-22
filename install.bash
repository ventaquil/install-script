#!/bin/bash

echo "Preparing the installer"
echo

if [ "`whoami`" != "root" ]
then
    echo "Run this script as root!"
    echo "  Psst. Hey kid. Use \`sudo\`."
    exit
fi

function program_is_installed {
    local return_=1

    type $1 >/dev/null 2>&1 || { local return_=0; }

    echo "$return_"
}

# Install PHP7.1
echo "Checking PHP 7.1"
if [ "`program_is_installed php7.1`" == "0" ]
then
    echo "  > install"
    add-apt-repository ppa:ondrej/php
    apt-get update
    apt-get install php7.1
else
    echo "  > looks good"
fi

# Install Git
echo "Checking Git"
if [ "`program_is_installed git`" == "0" ]
then
    echo "  > install"
    apt-get install git
else
    echo "  > looks good"
fi

# Install Apache2
echo "Checking Apache2"
if [ "`program_is_installed apache2`" == "0" ]
then
    echo "  > install"
    apt-get install apache2
else
    echo "  > looks good"
fi

# Install and enable PHP mcrypt
echo "Checking PHP mcrypt"
if [ "`php -m | grep mcrypt`" != "mcrypt" ]
then
    echo "  > install"
    apt-get install php7.1-mcrypt
    phpenmod mcrypt
else
    echo "  > looks good"
fi

# Install and enable PHP mbstring
echo "Checking PHP mbstring"
if [ "`php -m | grep mbstring`" != "mbstring" ]
then
    echo "  > install"
    apt-get install php7.1-mbstring
    phpenmod mbstring
else
    echo "  > looks good"
fi

# Install nodejs
echo "Checking nodejs"
if [ "`program_is_installed node`" == "0" ]
then
    echo "  > install"
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    apt-get install -y nodejs
else
    echo "  > looks good"
fi

# Install gulp
echo "Checking gulp"
if [ "`program_is_installed node`" == "0" ]
then
    echo "  > install"
    npm install -g gulp
else
    echo "  > looks good"
fi

apt-get autoclean
