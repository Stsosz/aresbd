#!/bin/bash
# AresBD Control Panel by Stsosz

setPort()
{
	read -rp "Receiving port: " PORT
}

shell()
{
	if [ -z "$PORT" ]; then
		echo "You need to set the port first!"
	else
		nc -l -p $PORT
	fi
}

setScript()
{
	cd ~/Ares/Scripts
	PS3='Script: '
	select SCRIPT in *; do
		PS3='ABDConsole: '
	break
done
}

showOpts()
{
	echo Hi
}

PS3='ABDConsole: '
options=("Set Port" "Set Script" "Show Options" "Quit")
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
        "Show Options")
			showOpts
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done