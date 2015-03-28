#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.

chmod +x ~/aresbd/abdconsole

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
