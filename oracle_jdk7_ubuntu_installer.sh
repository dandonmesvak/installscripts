#!/bin/bash
# 
# This is a simple script for installing Oracle 64bit jdk on Ubuntu 12.04 64bit
# 
# Author: Hanif F.M.
# License: GPLv3
# Version: 0.93
# 

ORACLE_DOWNLOAD_PATH="http://download.oracle.com/otn-pub/java/jdk/7u51-b13/"
FILE_NAME="jdk-7u51-linux-x64.tar.gz"
DEST_PATH="/usr/lib/jvm/"
CUR_FOLDER="jdk1.7.0_51"

##############################################################

echo 'Downloading from oracle...'
wget -c --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" "$ORACLE_DOWNLOAD_PATH$FILE_NAME" --output-document="$FILE_NAME"
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'failed to download the file '$FILE_NAME' from oracle.'
	exit 1
fi

###############################################################

echo 'extracting '$FILE_NAME
tar xzf $FILE_NAME
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'failed to extract the file!'
	exit 1
fi


###############################################################


echo 'checking if '$CUR_FOLDER' folder exists...'
if [ ! -d "$CUR_FOLDER" ]; then
	echo $CUR_FOLDER ' doenst exists. Quiting...'
	exit 1
fi


###############################################################

echo 'moving folder to' $DEST_PATH
if [ ! -d "$DEST_PATH" ]; then
	echo 'creating the destination path: '$DEST_PATH
	sudo mkdir -p $DEST_PATH

	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
		echo 'failed to create destination'
		exit 1
	fi
fi

sudo mv $CUR_FOLDER $DEST_PATH
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'failed to move '$CUR_FOLDER' to '$DEST_PATH
	exit 1
fi


##############################################################

echo 'configure alternatives...'

ERRORS=0

function CountErrors(){
	ERRORS=$(( $ERRORS + $? ));
}

#TODO: check if the mozilla plugin is installed...install the alter 
#MOZILLA_PLUGIN_PATH="/usr/lib/mozilla/plugins/libjavaplugin.so"
#if [ ! -f "$MOZILLA_PLUGIN_PATH" ]; then
#	echo "creating softlink to firefox java plugin"
#	sudo ln -s $MOZILLA_PLUGIN_PATH "/etc/alternatives/mozilla-javaplugin.so"
#	sudo ln -s "/usr/lib/jvm/jdk1.7.0_04/jre/lib/amd64/libnpjp2.so" "/usr/lib/mozilla/plugins/libnpjp2.so"
#fi

sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/$CUR_FOLDER/bin/java" 1
CountErrors
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/$CUR_FOLDER/bin/javac" 1
CountErrors
#sudo update-alternatives --install "$MOZILLA_PLUGIN_PATH" "mozilla-javaplugin.so" "/usr/lib/jvm/$CUR_FOLDER/jre/lib/amd64/libnpjp2.so" 1
#CountErrors
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/$CUR_FOLDER/bin/javaws" 1
CountErrors


echo 'setting the alternatives to use oracle java by default...'
sudo update-alternatives --set java "/usr/lib/jvm/$CUR_FOLDER/bin/java"
CountErrors
sudo update-alternatives --set javac "/usr/lib/jvm/$CUR_FOLDER/bin/javac"
CountErrors
sudo update-alternatives --set mozilla-javaplugin.so "/usr/lib/jvm/$CUR_FOLDER/jre/lib/amd64/libnpjp2.so"
CountErrors
sudo update-alternatives --set javaws "/usr/lib/jvm/$CUR_FOLDER/bin/javaws"
CountErrors

if [ $ERRORS != 0 ]; then
	echo 'Installation went ok but some configuration didnt. Sum of Errors: '$ERRORS
fi

echo 'cleaning up...'
rm $FILE_NAME

echo 'Installation and configuration done!'

exit 0

