#!/bin/bash
# AresBD Control Panel by Stsosz
# Don't be an asshole. Don't use this without permission. I'm not responsible for
# Any stupid stuff you do with AresBD.
# Define Variables

source ~/Ares/aresbd.conf
PS3=$MENUPROMPT

# Load Modules
cd ~/Ares/Modules
for file in * ; do
  if [ -f "$file" ] ; then
    source "$file"
  fi
done

cd ~/Ares

echo "======================================="
echo "                         ____  _____  ";
echo "     /\                 |  _ \|  __ \ ";
echo "    /  \   _ __ ___  ___| |_) | |  | |";
echo "   / /\ \ | '__/ _ \/ __|  _ <| |  | |";
echo "  / ____ \| | |  __/\__ \ |_) | |__| |";
echo " /_/    \_\_|  \___||___/____/|_____/ ";
echo "                              v$VERSION ";
echo "======================================="


# User Menu
select opt in "${mainoptions[@]}"
do
    case $opt in
        "Set Port")
			setPort
			echo ""
            ;;
        "Set Script")
            setScript
			echo ""
            ;;
		"Set Attack Mode")
			setAttack
			echo ""
			;;
        "Show Options")
			showOpts
			echo ""
            ;;
		"Start Attack")
			attackLogic
			echo ""
			;;
        "Quit")
            break
            ;;
		"Help")
			showHelp
			echo ""
			;;
        *) echo invalid option;;
    esac
done