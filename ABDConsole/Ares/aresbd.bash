#!/bin/bash
# AresBD Control Panel by Stsosz

# Define Variables
PS3='ABDConsole: '
options=("Set Port" "Set Script" "Set Attack Mode" "Show Options" "Start Attack" "Help" "Quit")

echo ===========================================================
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
echo ===========================================================

function showHelp()
{
	echo "Usage: aresbd"
	echo ""
	
	echo "Set Port: "
	echo "Set the port to listen on"
	echo ""
	
	echo "Set Script: "
	echo "Choose a script to send to the target in Script mode"
	echo ""
	
	echo "Set Attack Mode: "
	echo "Chose from 2 modes: Script and Shell"
	echo "In script mode, the selected script is"
	echo "fed line-by-line to the target."
	echo "In Shell mode, a remote shell, almost"
	echo "like SSH, is connected to the target."	
	echo ""
	
	echo "Show Options: "
	echo "List all user selected options."
	echo ""
	
	echo "Start Attack: "
	echo "Initiate either a Shell or Script attack."
	
	echo "Help: "
	echo "Show this message!"
	echo ""

	echo "Quit: "
	echo "I don't even..."
}

setPort()
# Set the port to listen on
{
	read -rp "Receiving port: " PORT
}

setAttack()
# Set the attack mode
{
	PS3='Attack Mode: '
	options=("Shell" "Script")
	select opt in "${options[@]}"
	do
	    case $opt in
	        "Shell")
	            ATTACKMODE=Shell
				PS3='ABDConsole: '
				break
	            ;;
	        "Script")
	            ATTACKMODE=Script
				PS3='ABDConsole: '
				break
	            ;;
	        *) echo invalid option;;
	    esac
	done
}

setScript()
# Choose a file to use with attackScript
{
	cd ~/Ares/Scripts
	PS3='Script: '
	select SCRIPT in *; do
		PS3='ABDConsole: '
		cd ~/Ares
	break
done
}

attackShell()
# Listen for incoming TCP connections.
{
	if [ -z "$PORT" ]; then
		echo "You need to set the port first!"
	else
		nc -l -p $PORT
	fi
}

attackScript()
# Listen for incoming TCP connections, and feed them the specified script.
{
	if [ -z "$PORT" ]; then
		echo "You need to set the port first!"
	elif [ -z "$SCRIPT" ]; then
		echo "You need to set the script first!"
	else
		echo Yay! It worked!
	fi
}

showOpts()
# Show the user what settings they have chosen
{
	if [ -z "$PORT" ]; then
		echo "No port chosen. "
	else
		echo Port: $PORT
	fi
	
	if [ -z "$SCRIPT" ]; then
		echo "No script chosen. "
	else
		echo Script: $SCRIPT
	fi
	
	if [ -z "$ATTACKMODE" ]; then
		echo "No attack mode chosen. "
	else
		echo Attack Mode: $ATTACKMODE
	fi
}

# Decide what attack function to use. 
function attackLogic()
{
	if [[ -z "$ATTACKMODE" ]]; then
	echo "You need to set an attack mode first!"
	fi
	
	if [[ $ATTACKMODE = "Shell" ]]; then
		attackShell
	fi
	
	if [[ $ATTACKMODE = "Script" ]]; then
		attackScript
	fi
}

# User Menu
select opt in "${options[@]}"
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
			attackScript
			;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done