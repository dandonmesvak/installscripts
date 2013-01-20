#!/bin/bash
#
# This is a simple script for instaling xampp 1.8.1 on Ubuntu 64bit
#
# Author: Hanif F.M.
# License: GPLv3
# Version: 0.2
# 

FILE_NAME="xampp-linux-1.8.1.tar.gz"
DOWNLOAD_PATH="http://www.apachefriends.org/download.php?xampp-linux-1.8.1.tar.gz"
INSTALL_LOCATION="/opt"

#Download XAMPP
wget $DOWNLOAD_PATH -O $FILE_NAME

#Extract XAMPP in the install location
sudo tar xvzf $FILE_NAME -C $INSTALL_LOCATION

#Change the perission of htdocs
sudo chmod 777 -R $INSTALL_LOCATION/lampp/htdocs


#Creating GUI for xampp-control-panel for Ubuntu Unity
sudo echo "[Desktop Entry]
Comment=Start and Stop XAMPP
Name=XAMPP Control Panel
Exec=gksudo python /opt/lampp/share/xampp-control-panel/xampp-control-panel.py
Icon[en_CA]=/usr/share/icons/Humanity/devices/24/network-wired.svg
Encoding=UTF-8
Terminal=false
Name[en_CA]=XAMPP Control Panel
Comment[en_CA]=Start and Stop XAMPP
Type=Application
Icon=/usr/share/icons/Humanity/devices/24/network-wired.svg" >> xampp-control-panel.desktop


sudo mv xampp-control-panel.desktop /usr/share/applications/xampp-control-panel.desktop



