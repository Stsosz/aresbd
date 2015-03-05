#!/bin/sh

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't be an asshole. Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.


VERSION=Dev
IP=`dig +short myip.opendns.com @resolver1.opendns.com `

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

echo -e 'Installing any missing packages... \c'
sleep 1

if [ -f /usr/bin/apt-get ]; then
    echo "Using apt-get."
    sudo apt-get update > /dev/null && apt-get upgrade -y > /dev/null
    sudo apt-get install -y git > /dev/null
fi

if [ -f /usr/bin/pacman ]; then
    echo "Using Pacman."
    sudo pacman –Syu
    sudo pacman -S git
fi

echo "Done."

echo -e "Creating temporary dir... \c"
TEMPFILE=`sudo mktemp -d -t Ares-Install.XXX`
echo "Done."

echo "Downloading git repo..."

git init $TEMPFILE > /dev/null
cd $TEMPFILE
git remote add origin https://gitlab.stsosz.io/Stsosz/aresbd.git > /dev/null
git pull --depth=1 origin $VERSION > /dev/null

echo "Done."

echo -e "Installing Files... \c"
mv "$TEMPFILE"/ABDConsole/Ares ~/Ares
echo "Done."


echo -e "Removing temporary dir... \c"
rm -rf ~/$TEMPFILE
echo "Done."

echo "Setting up the USB installer..."

echo -e "Writing current IP to ares.conf..."
echo "SERVER=$IP" >> ~/Ares/Server/Files/ares.conf
echo "Done."

read -p "Would you like to copy ~/Ares/abdconsole.bash to /usr/bin/abdconsole?: (Y/N)? "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    chmod +x ~/Ares/abdconsole.bash
    rm ~/ABDInstall.sh
    chown -R $USER:$USER ~/Ares/
    echo "Done!"
    exit
else
    echo -e "Copying... \c"
    cp ~/Ares/abdconsole.bash /usr/bin/abdconsole
    chmod +x /usr/bin/abdconsole
    chmod +x ~/Ares/abdconsole.bash
    rm ~/ABDInstall.sh
    chown -R $USER:$USER ~/Ares/
    echo "Done!"
    exit
fi
echo "Installation complete. Run the AresBD control panel with:"
echo "sudo abdconsole"
