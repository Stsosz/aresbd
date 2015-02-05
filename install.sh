#!/bin/sh

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.

if [[ $UID != 0 ]]; then
echo "Please run this script with sudo:"
echo "sudo $0 $*"
exit 1
fi

echo 'Welcome to the Stsosz Systems ABDConsole Installer.'

read -p "Would you like to proceed with installation: (Yes/No)? "
if [[ ! $REPLY =~ ^[YyEeSs]$ ]]; then
    echo "Exiting"
    exit 0
else
    echo "Starting Installation..."
fi

echo 'Installing any missing packages...'

if [ -f /usr/bin/apt-get ]; then
echo "Using apt-get..."
apt-get update && apt-get upgrade -y
sudo apt-get install -y git
fi

if [ -f /usr/bin/pacman ]; then
echo "Using Pacman..."
pacman –Syu
pacman -S git
fi

echo "Done."

echo "Downloading from git repo..."

cd ~
git init Ares-Install
cd Ares-Install
git remote add origin https://gitlab.stsosz.io/Stsosz/aresbd.git
git pull --depth=1 origin Release

echo "Done."

echo "Installing Files..."
mv -v ~/Ares-Install/ABDConsole/Ares ~/

rm -rf ~/Ares-Install