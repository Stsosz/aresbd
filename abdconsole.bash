#!/bin/bash

#  aresbd.bash
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't be an asshole. Don't use this without permission. I'm not responsible
#  for any stupid stuff you do with AresBD.

#Make sure that user uses sudo
if [[ $UID != 0 ]]; then
echo "Please run again with sudo: "
echo "sudo $0 $*"
exit 1
fi

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