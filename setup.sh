#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.

IP=`dig +short myip.opendns.com @resolver1.opendns.com `

echo "SERVER=$IP" >> ~/aresbd/Server/Files/ares.conf
echo "COMMANDSERVER=$IP" >> ~/aresbd/Server/Files/ares.conf


chmod +x ~/aresbd/abdconsole
chown -R $USER:$USER ~/aresbd/

if [ -f ~/.bashrc ];
then
    echo PATH="$PATH"":~/aresbd/" >> ~/.bashrc
    source ~/.bashrc
fi

if [ -f ~/.bash_profile ];
then
    echo PATH="$PATH"":~/aresbd/" >> ~/.bash_profile
    source ~/.bash_profile
fi

rm ~/aresbd/setup.sh

echo "Done!"
