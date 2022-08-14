r="\e[31m"; g="\e[32m"; y="\e[33m"; e="\e[0m" # color presets

DownloadsDoneMessage () { echo -e "${g}Downloads done. It should be in your Downloads folder.${e}"; }

BeforeDownloadRoutine () {
    bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)"; cd ..; cd ..; cd ..; cd ..; cd ..; cd sdcard; cd download;
}

TypeNQualitySelectionSingleMedia () {
    echo -e "${y}What kind of downloads do you want?${e}"
    echo -e "${y}(A) Audio Only${e}"
    echo -e "${y}(V) YouTube Video${e}"
    echo -e "${y}(N) Non-YouTube Video${e}"
    echo -e "${y}Enter neither will exit the program.${e}"
    read -e -p "Pick Your Poison: " typeselection
	
    if [ "$typeselection" = "A" ]
    then
        echo "${y}Audio only download selected. Downloading...${e}"
        BeforeDownloadRoutine
        yt-dlp $youtubelink -f "ba" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage
		
    elif [ "$typeselection" = "N" ]
    then
        echo "${y}Non-YouTube Video download selected. Downloading...${e}"
        echo "${y}(By default, this will download in highest quality, due to most non video centric website usually stream 720p max)${e}"
        BeforeDownloadRoutine
        yt-dlp $youtubelink -f "bv" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage
		
    elif [ "$typeselection" = "V" ]
    then
        echo "${y}YouTube Video download selected. Choose resolution...${e}"
        echo "${y}(1080) 1920x1080 video${e}"
        echo "${y}(2K) 2560x1440 video${e}"
        echo "${y}(4K) 3840x2160 video${e}"
        echo "${y}(entering neither, or non-availability of resolution selected, will result to program selecting the highest resolution video available)${e}"
        read -e -p "Pick a resolution: " resolution
		
        if [ "$resolution" = "1080" ]
        then
            echo "${y}1080p resolution selected. Downloading...${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=1920]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        elif [ "$resolution" = "2K" ]
        then
            echo "${y}2K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=2560]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        elif [ "$resolution" = "4K" ]
        then
            echo "${y}4K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=3840]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        else
            echo "${y}Neither of resolution entered matched. Downloading highest quality video available...${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
        fi
    else
        echo "${r}Neither of options entered matched. Exiting...${e}"
        exit
    fi
}

clear;
echo -e "${g}      ======================================${e}"
echo -e "${g}       YOUTUBE DOWNLOADER BY HAIZI IZZUDIN${e}"
echo -e "${g}       ANDROID VERSION 0.2a${e}"
echo -e "${g}       POWERED BY YT-DLP AND FFMPEG${e}"
echo -e "${g}       INSTALL SCRIPT BY lostb053 ON GITHUB${e}"
echo -e "${g}      ======================================${e}"
read -e -p "Paste YouTube URL: " youtubelink
TypeNQualitySelectionSingleMedia;
