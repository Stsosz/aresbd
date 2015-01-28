#!/bin/bash
# AresBD Control Panel by Stsosz
# Define Variables

PS3='ABDConsole: '
options=("Set Port" "Set Script" "Set Attack Mode" "Show Options" "Start Attack" "Quit")

setPort()
{
	read -rp "Receiving port: " PORT
}

setAttack()
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
{
	if [ -z "$PORT" ]; then
		echo "You need to set the port first!"
	else
		nc -l -p $PORT
	fi
}

attackScript()
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