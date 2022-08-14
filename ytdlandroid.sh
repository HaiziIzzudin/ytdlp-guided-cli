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

CheckPrereq () { # check if yt-dlp and ffmpeg available in device (provided by github.com/lostb053/ytdl-termux)

    if [ -f "/sdcard/download/ytdlhaizi-softwareid" ]; then
        echo "Prerequisites file still exists. Proceeding to next step..."
    else 
        echo -e "${yellow}You don't have prerequisites available. Allow software to download it first...${e}"
        echo
        DownloadAndInstallPrereq
        changeDirToDownload
        touch ytdlhaizi-softwareid
        echo
        echo -e "${yellow}A software identifier has been made in your Downloads directory.${e}"
        echo -e "${red}DO NOT DELETE THIS FILE.${e}"
        echo -e "${yellow}This file works as an identifier if prerequisites has been installed in your device.${e}"
        echo -e "${yellow}Erasing this file can cause redundancy of installer and can take your precious storage space. Understood?${e}"
        echo
        read -p "Press enter to agree..."
    fi
}

DownloadAndInstallPrereq () {
    bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)"
}



# actual working program starts here...
clear
echo -e "${green}====================================${e}"
echo -e "${green}YOUTUBE DOWNLOADER BY HAIZI IZZUDIN${e}"
echo -e "${green}ANDROID VERSION 0.2a${e}"
echo -e "${green}POWERED BY YT-DLP AND FFMPEG${e}"
echo -e "${green}INSTALL SCRIPT BY lostb053 ON GITHUB${e}"
echo -e "${green}====================================${e}"
echo 
echo -e "${green}This program will download the best quality available to your Downloads folder.${e}"
echo 
echo -e "${yellow}Enter YouTube URL:${e}"
read youtubelink
echo
CheckPrereq # perform file checks b4 downloading
changeDirToDownload # cd to downloads folder to download video to working dir
echo -e "${yellow}Starting download...${e}"
echo
yt-dlp $youtubelink -f "bv+ba" -o "%(playlist_autonumber)d %(channel)s %(id)s.%(ext)s"
echo 
echo -e "${yellow}Downloads done. It should be in Downloads folder in your phone directory.${e}"
echo