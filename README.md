auto-ffmpeg
===========

Auto FFMpeg Installer for CentOS 6+

####Requirements:
* CentOS 6+
* PuTTY

That's all! Did you expected more? 

####Why use this ?

Installation of FFMPEG is treated as the toughest installations as it has many dependencies.
So I made this script, to simply the issues.
Check with the below steps for easy installation.

####Installation:

```bash
$> yum update -y
$> yum install wget -y
$> wget "https://raw.githubusercontent.com/itseasy21/auto-ffmpeg/master/install-ffmpeg.sh" -O /root/install-ffmpeg.sh
$> cd /root
$> chmod +x install-ffmpeg.sh
$> ./install-ffmpeg.sh
```

Auto FFMpeg Installer Proudly Presented by http://www.w3tool.blogspot.in/
