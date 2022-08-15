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
    echo -e "${y}Enter neither will bring you back to Main Menu${e}"
    read -e -p "Pick Your Poison: " typeselection
	
    if [ "$typeselection" =~ (A|a) ]
    then
        echo -e "${y}Audio only download selected. Downloading...${e}"
        BeforeDownloadRoutine
        yt-dlp $youtubelink -f "ba" -o "%(title)s.%(ext)s"
        DownloadsDoneMessage
		
    elif [ "$typeselection" =~ (N|n) ]
    then
        echo -e "${y}Non-YouTube Video download selected. Downloading...${e}"
        echo -e "${y}(By default, this will download in highest quality, due to most non video centric website usually stream 720p max)${e}"
        BeforeDownloadRoutine
        yt-dlp $youtubelink -o "%(title)s.%(ext)s"
        DownloadsDoneMessage
		
    elif [ "$typeselection" =~ (V|v) ]
    then
        echo -e "${y}YouTube Video download selected. Please specify any of special resolution below. Leaving others/blank will defaulted to 1080p.${e}"
        echo -e "${y}(2K) 2560x1440 video${e}"
        echo -e "${y}(4K) 3840x2160 video${e}"
        read -e -p "Pick a resolution: " resolution
		
        if [ "$resolution" =~ (2K|2k) ]
        then
            echo -e "${y}2K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=2560]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        elif [ "$resolution" =~ (4K|4k) ]
        then
            echo -e "${y}4K resolution selected. Downloading...${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=3840]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        else
            echo -e "${y}Downloading defaults (1080p)${e}"
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=1920]+ba" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
        fi
    else
        echo -e "${r}Neither of options entered matched. Exiting to Main Menu...${e}"
        MainMenu;
    fi
}

MainMenu () {
    clear;
    echo -e "${g}      ======================================${e}"
    echo -e "${g}       YOUTUBE DOWNLOADER BY HAIZI IZZUDIN${e}"
    echo -e "${g}       ANDROID VERSION 0.2a${e}"
    echo -e "${g}       POWERED BY YT-DLP AND FFMPEG${e}"
    echo -e "${g}       INSTALL SCRIPT BY lostb053 ON GITHUB${e}"
    echo -e "${g}      ======================================${e}"
    read -e -p "Paste YouTube URL: " youtubelink
    TypeNQualitySelectionSingleMedia;
}

MainMenu;