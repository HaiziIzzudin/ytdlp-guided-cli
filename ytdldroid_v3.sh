r="\e[31m"; g="\e[32m"; y="\e[33m"; e="\e[0m"; # color presets

DownloadsDoneMessage () { echo -e "${g}Downloads done. It should be in your Downloads folder.${e}"; }

BeforeDownloadRoutine () {
    bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)"; cd ..; cd ..; cd ..; cd ..; cd ..; cd sdcard; cd download;
}

TypeNQualitySelectionSingleMedia () {
    echo -e "${y}Please specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video.${e}"
    echo -e "${y}(A) Audio Only${e}"
    echo -e "${y}(N) Non-YouTube Video${e}"
    read -e -p "Pick Your Poison: " typeselection
	
    if [[ "$typeselection" =~ (A|a) ]]
    then # Download audio only
        BeforeDownloadRoutine
        yt-dlp $youtubelink -f "ba" -o "%(title)s.mp3"
        DownloadsDoneMessage
        
    elif [[ "$typeselection" =~ (N|n) ]]
    then # Download max quality due to these platform dont separate video and audio.
        BeforeDownloadRoutine
        yt-dlp $youtubelink -o "%(title)s.%(ext)s"
        DownloadsDoneMessage
		
    else
        echo -e "${y}Defaults (YouTube Video) selected. Please specify any of special resolution below. Leaving others/blank will defaulted to 1080p.${e}"
        echo -e "${y}(2K) 2560x1440 video${e}"
        echo -e "${y}(4K) 3840x2160 video${e}"
        read -e -p "Pick a resolution: " resolution
		
        if [[ "$resolution" =~ (2K|2k) ]]
        then # Download 2k resolution av1 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=2560]+ba" -S "vcodec:av01" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        elif [[ "$resolution" =~ (4K|4k) ]]
        then # Download 4k resolution av1 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=3840]+ba" -S "vcodec:av01" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
			
        else # Download 1080p resolution av1 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -f "bv*[width<=1920]+ba" -S "vcodec:av01" -o "%(title)s.%(ext)s"
            DownloadsDoneMessage
        fi
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

