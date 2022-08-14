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
    echo -e "${yellow}What kind of downloads do you want?${e}"
    echo -e "${yellow}[A] Audio Only${e}"
    echo -e "${yellow}[V] YouTube Video${e}"
    echo -e "${yellow}[N] Non-YouTube Video${e}"
    echo -e "${yellow}Enter neither will exit the program.${e}"
    read -e -p "Pick Your Poison: " typeselection
	
    if [ "$typeselection" = "A" ]; then
        echo "${yellow}Audio only download selected. Downloading...${e}"
        BeforeDownloadRoutine;
        yt-dlp $youtubelink -f "ba" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage;
		
    elif [ "$typeselection" = "N" ]; then
        echo "${yellow}Non-YouTube Video download selected. Downloading...${e}"
        echo "${yellow}(By default, this will download in highest quality, due to most non video centric website usually stream 720p max)${e}"
        BeforeDownloadRoutine;
        yt-dlp $youtubelink -f "bv" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage;
		
    elif [ "$typeselection" = "V" ]; then
        echo "${yellow}YouTube Video download selected. Choose resolution...${e}"
        echo "${yellow}[1080] 1920x1080 video${e}"
        echo "${yellow}[2K] 2560x1440 video${e}"
        echo "${yellow}[4K] 3840x2160 video${e}"
        echo "${yellow}(entering neither, or non-availability of resolution selected, will result to program selecting the highest resolution video available)${e}"
        read -e -p "Pick a resolution: " resolution
		
        if [ "$resolution" = "1080" ]; then
            echo "${yellow}1080p resolution selected. Downloading...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*[width<=1920]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
			
        elif [ "$resolution" = "2K" ]; then
            echo "${yellow}2K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*[width<=2560]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
			
        elif [ "$resolution" = "4K" ]; then
            echo "${yellow}4K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*[width<=3840]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
			
        else
            echo "${yellow}Neither of resolution entered matched. Downloading highest quality video available...${e}"
            BeforeDownloadRoutine;
            yt-dlp $youtubelink -f "bv*+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage;
        fi
    else
        echo "${red}Neither of options entered matched. Exiting...${e}"
        exit;
    fi
}

EnterYTLink () { read -e -p "Paste YouTube URL: " youtubelink }

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
