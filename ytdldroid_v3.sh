red="\e[31m"
green="\e[32m"
yellow="\e[33m"
e="\e[0m"

DownloadsDoneMessage () { echo -e "${green}Downloads done. It should be in your Downloads folder.${e}" }

BeforeDownloadRoutine () {
    bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)";
    cd ..
    cd ..
    cd ..
    cd ..
    cd ..
    cd sdcard
    cd download
}

TypeNQualitySelectionSingleMedia () {
    echo -e "${yellow}What kind of downloads do you want?\n\n[A] Audio Only\n[V] YouTube Video\n[N] Non-YouTube Video\n\nEnter neither will exit the program.${e}"
    read -e -p "Pick Your Poison: " typeselection
	
    if [ "$typeselection" = "A" ]; then
        echo "${yellow}\nAudio only download selected. Downloading...\n${e}"
        BeforeDownloadRoutine;
        yt-dlp $youtubelink -f "ba" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage;
		
    elif [ "$typeselection" = "N" ]; then
        echo "${yellow}\nNon-YouTube Video download selected. Downloading...${e}"
        echo "${yellow}\n(By default, this will download in highest quality, due to most non video centric website usually stream 720p max)${e}"
        BeforeDownloadRoutine;
        yt-dlp $youtubelink -f "bv" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage;
		
    elif [ "$typeselection" = "V" ]; then
        echo "${yellow}\nYouTube Video download selected. Choose resolution...\n\n[1080] 1920x1080 video\n[2K] 2560x1440 video\n[] 3840x2160 video\n\n(entering neither, or non-availability of resolution selected, will result to program selecting the highest resolution video available)${e}"
        read -e -p "\n\nPick a resolution: " resolution
		
        if [ "$resolution" = "1080" ]; then
            echo "${yellow}\n1080p resolution selected. Downloading...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*[width<=1920]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
			
        elif [ "$resolution" = "2K" ]; then
            echo "${yellow}\n2K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*[width<=2560]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
			
        elif [ "$resolution" = "4K" ]; then
            echo "${yellow}\n4K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*[width<=3840]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
			
        else
            echo "${yellow}\nNeither of resolution entered matched. Downloading highest quality video available...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
        fi
    else
        echo "${red}\nNeither of options entered matched. Exiting...${e}"
        exit;
    fi
}

EnterYTLink () { read -e -p "\nPaste YouTube URL: \n" youtubelink }

Header () {
    echo -e "${green}      ======================================${e}"
    echo -e "${green}       YOUTUBE DOWNLOADER BY HAIZI IZZUDIN${e}"
    echo -e "${green}       ANDROID VERSION 0.2a${e}"
    echo -e "${green}       POWERED BY YT-DLP AND FFMPEG${e}"
    echo -e "${green}       INSTALL SCRIPT BY lostb053 ON GITHUB${e}"
    echo -e "${green}      ======================================${e}"
    echo
}

clear; 
Header; 
EnterYTLink; 
TypeNQualitySelectionSingleMedia;
