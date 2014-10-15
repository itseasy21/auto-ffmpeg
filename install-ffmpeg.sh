#!/bin/bash

#This script will install and configure the following modules for you
# ffmpeg 0.7.11, mencoder, mplayer, mp4box2 and more libs

### Made by Shubham Mathur (itseasy21)

#-Colors :D
RED='\033[01;31m'
GREEN='\033[01;32m'
RESET='\033[0m'

#--Clearing Your Screen
clear

echo -e "$GREEN----------------------------------------$RESET"
echo -e "     $RED W3TooLS FFMpeg Installer $RESET"
echo -e "              Version 0.1.1            "
echo -e "     http://www.w3tool.blogspot.in/  "
echo -e "$GREEN----------------------------------------$RESET"

#-Yum Check
echo -ne "Checking for Yum .."
if [ -e  "/etc/yum.conf" ]; then
	echo -e "[ $GREEN Found $RESET ]"
else
	echo -e "[ $RED Not Found $RESET ]"
	exit
fi

#--Making Sure we have required libs
cd /root
yum install vim wget sed rpm gcc -y

#--Libs Check
echo " "
echo -ne "Checking for SED .."
if [ -e  "/bin/sed" ]; then
	echo -e "[ $GREEN Found $RESET ]"
else
	echo -e "[ $RED Not Found $RESET ]"
	exit
fi

#--checking old ffmpeg installation
echo -ne "Searching for Previous FFMpeg Installation .."
if [ -e  "/usr/bin/ffmpeg" ]; then
	echo -e "[ $RED FFMpeg Found.\n Exiting Install. $RESET ]"
	exit
else
	echo -e "[ $GREEN FFMpeg Not Found, Proceeding ... $RESET ]"
fi

#--Adding repo
cd /root
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
wget --no-check-certificate https://raw.githubusercontent.com/itseasy21/auto-ffmpeg/master/auto-ffmpeg.repo -O /etc/yum.repos.d/auto-ffmpeg.repo

#getting os info
os=$( uname -i )

#installing ffmpeg, mplayer, mp4box2, and other libs
if [ "$os" = "x86_64" ]
then
   yum install ffmpeg mplayer gpac gpac-libs ffmpeg-devel --exclude "*.i386" -y
else
   yum install ffmpeg mplayer gpac gpac-libs ffmpeg-devel -y
fi

#installing ffmpeg-php 
cd /root
wget http://downloads.sourceforge.net/ffmpeg-php/ffmpeg-php-0.6.0.tbz2
tar xjf ffmpeg-php-0.6.0.tbz2
cd ffmpeg-php-0.6.0
sed -i 's/PIX_FMT_RGBA32/PIX_FMT_RGB32/g' ffmpeg_frame.c
#3 new fix for centos 6.5 
sed -i 's/list_entry *le/zend_rsrc_list_entry *le/g' ffmpeg_movie.c
sed -i 's/list_entry new_le/zend_rsrc_list_entry new_le/g' ffmpeg_movie.c
sed -i 's/sizeof(list_entry)/sizeof(zend_rsrc_list_entry)/g' ffmpeg_movie.c
phpize
./configure
make
make install

#finding php.ini and adding ffmpeg in it
phpini=$( (php -i | grep "Loaded Configuration File") | sed -e 's/Loaded Configuration File => //g' )
echo "extension=\"ffmpeg.so\"" >> $phpini

#restarting http
/etc/init.d/httpd restart

#finished
echo -e "$GREEN ---------------------------------------------------$RESET"
echo -e "$GREEN      FFMpeg Installation Complete       $RESET"
echo -e "        Below are the paths of various libs  "
echo -e " 
    ffmpeg:$GREEN /usr/bin/ffmpeg $RESET
    mplayer:$GREEN /usr/bin/mplayer $RESET
    mencoder:$GREEN /usr/bin/mencoder $RESET
    MP4Box:$GREEN /usr/bin/MP4Box $RESET"
echo -e ""
echo -e "If ffmpeg failed to install or you faced any bugs feel free to post them with install log at $GREEN https://github.com/itseasy21/ $RESET"
echo -e ""
echo -e "Thanks for using our FFMpeg Installer for CentOS"
echo -e "For more stay tuned at our blog : $GREEN http://www.w3tool.blogspot.in/ $RESET"
echo -e "$GREEN---------------------------------------------------$RESET"
