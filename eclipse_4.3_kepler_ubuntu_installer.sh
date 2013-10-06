#!/bin/bash
# 
# This is a simple script for installing Eclipse Java 4.3 (Kepler) on Ubuntu 12.04 64bit
# 
# Author: Hanif F.M.
# License: GPLv3
# Version: 0.91
# 




ECLIPSE_DIRECT_DOWNLOAD_PATH="http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/kepler/SR1/eclipse-java-kepler-SR1-linux-gtk-x86_64.tar.gz&r=1"
FILE_NAME="eclipse-java-kepler-SR1-linux-gtk-x86_64.tar.gz"
DEST_PATH="/etc/opt/ide/"
CUR_FOLDER="eclipse_kepler"

##############################################################

echo 'Downloading from eclipse...'
wget "$ECLIPSE_DIRECT_DOWNLOAD_PATH" --output-document="$FILE_NAME"
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'failed to download the file '$FILE_NAME' from eclipse.'
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


echo 'checking if eclipse folder exists...'
if [ ! -d "eclipse" ]; then
	echo 'eclipse folder doenst exists. Quiting...'
	exit 1
fi


###############################################################

echo 'moving eclipse folder to' $DEST_PATH
if [ ! -d "$DEST_PATH" ]; then
	echo 'creating the destination path: '$DEST_PATH
	sudo mkdir -p $DEST_PATH

	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
		echo 'failed to create destination'
		exit 1
	fi
fi

sudo mv 'eclipse' $DEST_PATH$CUR_FOLDER
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'failed to move eclipse folder to '$DEST_PATH$CUR_FOLDER
	exit 1
fi


##############################################################

echo 'configure alternatives...'

ERRORS=0

function CountErrors(){
	ERRORS=$(( $ERRORS + $? ));
}

sudo update-alternatives --install "/usr/bin/eclipse" "eclipse" "$DEST_PATH$CUR_FOLDER/eclipse" 1
CountErrors

echo 'setting the alternatives to use this eclipse as default...'
sudo update-alternatives --set eclipse "$DEST_PATH$CUR_FOLDER/eclipse"
CountErrors

if [ $ERRORS != 0 ]; then
	echo 'Installation went ok but some configuration didnt. Sum of Errors: '$ERRORS
fi

#echo 'cleaning up...'
#rm $FILE_NAME

echo 'Installation and configuration done!'

exit 0

