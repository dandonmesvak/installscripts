#!/bin/bash
# 
# This is a simple script for installing curl 7.29 with c-ares on Ubuntu 12.04.
# 
# Author: Hanif F.M.
# License: GPLv3
# Version: 0.11
# 




DIRECT_DOWNLOAD_PATH="http://curl.haxx.se/download/"
FILE_NAME="curl-7.29.0.tar.gz"
EXTRACTED_FOLDER="curl-7.29.0"

##############################################################

echo 'Downloading from cURL...'
wget "$DIRECT_DOWNLOAD_PATH$FILE_NAME"
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'failed to download the file '$FILE_NAME'.'
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

##############################################################

echo 'configuring and installing curl with c-ares'

#sudo apt-get install libc-ares2
sudo apt-get install libc-ares-dev

cd $EXTRACTED_FOLDER
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'faild to cd into ' $EXTRACTED_FOLDER'.'
	exit 1
fi

./configure --enable-ares && make && sudo make install

RETVAL=$?
if [ $RETVAL -ne 0 ]; then
	echo 'could not configure or install curl with c-ares.' 
	exit 1
fi

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

#echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> ~/.bashrc


##############################################################


echo 'Installation and configuration done!'

exit 0


