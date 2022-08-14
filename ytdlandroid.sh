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

ChangeDirToDownload () { # since termux by default did not open in user downloads
    cd ..
    cd ..
    cd ..
    cd ..
    cd ..
    cd sdcard
    cd download
}

InstallUpdatePrereq () { # install/update prereq packages (provided by github.com/lostb053/ytdl-termux)
    bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)"
    # package has update script, no warning of overwrite will be issued.
}

Header () {
    echo -e "${green}      ======================================${e}"
    echo -e "${green}       YOUTUBE DOWNLOADER BY HAIZI IZZUDIN${e}"
    echo -e "${green}       ANDROID VERSION 0.2a${e}"
    echo -e "${green}       POWERED BY YT-DLP AND FFMPEG${e}"
    echo -e "${green}       INSTALL SCRIPT BY lostb053 ON GITHUB${e}"
    echo -e "${green}      ======================================${e}"
    echo
}

TypeNQualitySelection () {
    echo -e "What kind of downloads do you want?"
}

# actual working program starts here...
clear; Header;
read -e -p "Paste YouTube URL: " youtubelink
echo
InstallUpdatePrereq # perform prereq checks b4 downloading
ChangeDirToDownload # cd to downloads folder to download video on
echo -e "${yellow}Starting download...${e}"
echo
yt-dlp $youtubelink -f "bv+ba" -o "%(playlist_autonumber)d %(channel)s %(id)s.%(ext)s"
echo 
echo -e "${yellow}Downloads done. It should be in Downloads folder in your phone directory.${e}"
echo