#!/bin/sh

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't be an asshole. Don't use this without permission. I'm not responsible for
#  Any stupid stuff you do with AresBD.


VERSION=Dev

if [[ $UID != 0 ]]; then
echo "Please run this script with sudo:"
echo "sudo $0 $*"
exit 1
fi

clear
echo 'Welcome to the Stsosz Systems ABDConsole Installer.'

read -p "Would you like to proceed with installation: (Y/N)? "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Exiting"
    exit 0
else
    echo "Starting Installation..."
fi

echo 'Installing any missing packages...'
sleep 1

if [ -f /usr/bin/apt-get ]; then
    echo "Using apt-get..."
    sudo apt-get update && apt-get upgrade -y
    sudo apt-get install -y git
fi

if [ -f /usr/bin/pacman ]; then
    echo "Using Pacman..."
    sudo pacman –Syu
    sudo pacman -S git
fi

echo "Done."

echo "Creating temporary dir..."
TEMPFILE=`sudo mktemp -d -t Ares-Install.XXX`
echo "Done."

echo "Downloading git repo..."

git init $TEMPFILE
cd $TEMPFILE
git remote add origin https://gitlab.stsosz.io/Stsosz/aresbd.git
git pull --depth=1 origin $VERSION

echo "Done."

echo "Installing Files..."
mv -v "$TEMPFILE"/ABDConsole/Ares ~/Ares
echo "Done."


echo "Removing temporary dir..."
rm -rf ~/$TEMPFILE
echo "Done."

read -p "Would you like to copy ~/Ares/abdconsole.bash to /usr/bin/abdconsole?: (Y/N)? "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    chmod +x ~/Ares/abdconsole.bash
    rm ~/ABDInstall.sh
    echo "Done!"
    exit
else
    echo "Copying..."
    cp ~/Ares/abdconsole.bash /usr/bin/abdconsole
    chmod +x /usr/bin/abdconsole
    chmod +x ~/Ares/abdconsole.bash
    rm ~/ABDInstall.sh
    echo "Done!"
    exit
fi