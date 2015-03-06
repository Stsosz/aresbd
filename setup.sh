#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't be an asshole. Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.

IP=`dig +short myip.opendns.com @resolver1.opendns.com `

echo "SERVER=$IP" >> ~/aresbd/Server/Files/ares.conf
echo "COMMANDSERVER=$IP" >> ~/aresbd/Server/Files/ares.conf


chmod +x ~/aresbd/abdconsole.bash
chown -R $USER:$USER ~/aresbd/

if [ -f ~/.bashrc ];
then
    echo "$PATH"":~/aresbd/" >> ~/.bashrc
fi

if [ -f ~/.bash_profile ];
then
    echo "$PATH"":~/aresbd/" >> ~/.bash_profile
fi
