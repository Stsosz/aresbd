#!/bin/bash
#AresBD control panel installer by STSOSZ
echo "This installer will install the AresBD backdoor control panel."
read -p "Please confirm the installation by pressing RETURN"
echo "Starting installation"
echo "Creating directories..."
mkdir ~/Ares
mkdir ~/Ares/Scripts
echo "Done"
echo "Copying files..."
cp ~/abdinstall/aresbd /usr/bin/aresbd
cp ~/abdinstall/ares.conf ~/Ares/ares.conf
cp -r ~/abdinstall/Scripts ~/ares/Scripts
chmod +x /usr/bin/aresbd
echo "Installation complete."
echo "Exiting..."
exit