#!/bin/bash
# AresBD Control Panel by Stsosz

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

echo "=========================================================="
echo "                         ____  _____                     ";
echo "     /\                 |  _ \|  __ \                    ";
echo "    /  \   _ __ ___  ___| |_) | |  | |                   ";
echo "   / /\ \ | '__/ _ \/ __|  _ <| |  | |                   ";
echo "  / ____ \| | |  __/\__ \ |_) | |__| |                   ";
echo " /_/    \_\_|  \___||___/____/|_____/ ____   _____ ______";
echo " | |            / ____|__   __/ ____|/ __ \ / ____|___  /";
echo " | |__  _   _  | (___    | | | (___ | |  | | (___    / / ";
echo " | '_ \| | | |  \___ \   | |  \___ \| |  | |\___ \  / /  ";	
echo " | |_) | |_| |  ____) |  | |  ____) | |__| |____) |/ /__ ";
echo " |_.__/ \__, | |_____/   |_| |_____/ \____/|_____//_____|";
echo "         __/ |                                           ";
echo "        |___/                                            ";
echo "=========================================================="


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