#!/bin/bash

#  aresbd.bash
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't be an asshole. Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.

source ~/aresbd/aresbd.conf
PS3=$MENUPROMPT

# Load Modules
cd ~/aresbd/Modules
for file in *.abdmodule ; do
  if [ -f "$file" ] ; then
    source "$file"
  fi
done

cd ~/aresbd

showSplash
showMenu