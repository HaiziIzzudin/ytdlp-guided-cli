#!/bin/bash
# This command still don't have a way to install the module. Please refer guide on how to instal yt-dlp and ffmpeg for android.
#Note to dev, you need to prep a file like /storage/downloads to mirror android.

red="\e[31m"
green="\e[32m"
yellow="\e[33m"
orange="\e[34m"
magenta="\e[35m"
cyan="\e[36m"
e="\e[0m"

changeDirToDownload () { # since termux by default did not open in user downloads
    cd ..
    cd ..
    cd ..
    cd ..
    cd ..
    cd sdcard
    cd download
}

# actual working program starts here...
echo -e "${green}YOUTUBE DOWNLOADER BY HAIZI IZZUDIN: ANDROID VERSION 0.1a${e}"
echo -e "${green}POWERED BY YT-DLP AND FFMPEG, MODULE INSTALLS BY github.com/lostb053${e}"
echo 
echo -e "${green}This program will download the best quality available to the /Downloads directory.${e}"
echo 
echo -e "${yellow}Enter YouTube URL:${e}"
read youtubelink
changeDirToDownload # cd to downloads folder to download video to working dir
echo 
yt-dlp $youtubelink -f "bv+ba"
echo 
echo -e "${yellow}Downloads done. It should be in Downloads folder in your phone directory.${e}"