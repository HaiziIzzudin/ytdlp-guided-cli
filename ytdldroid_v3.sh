r="\e[31m"; g="\e[32m"; y="\e[33m"; e="\e[0m"; # color presets

DownloadsDoneMessage () { 
    echo -e "${g}Downloads done. It should be in your Downloads folder.${e}"
    echo
    echo "Key in C to download more. Key in other to exit program."
    read -e -p "Option: " continueorabort

    if [[ "$continueorabort" =~ (C|c) ]]
    then # back to input yt url
        MainMenu
     
     else # exit program
        exit;
}

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
        yt-dlp $youtubelink -f "ba" --recode-video mp3
        DownloadsDoneMessage
        
    elif [[ "$typeselection" =~ (N|n) ]]
    then # Download max quality due to these platform dont separate video and audio.
        BeforeDownloadRoutine
        yt-dlp $youtubelink
        DownloadsDoneMessage
		
    else
        echo -e "${y}Defaults (YouTube Video) selected. Please specify any of special resolution below. Leaving others/blank will defaulted to 1080p.${e}"
        echo
        echo "AV1 offers better video compression quality for a cost of your CPU resources. DO NOT PICK THIS if your phone did not have AV1 decode capabilities."
        echo -e "${y}(2V1) 2560x1440 AV1 video${e}"
        echo -e "${y}(4V1) 3840x2160 AV1 video${e}"
        echo
        echo "VP9 has lower compression quality in a cost of a lower cpu usage. Recommended because its a common codec widely adopted by media players."
        echo -e "${y}(2P9) 2560x1440 VP9 video${e}"
        echo -e "${y}(4P9) 3840x2160 VP9 video${e}"
        echo
        read -e -p "Pick a resolution: " resolution
		
        if [[ "$resolution" =~ (2V1|2v1) ]]
        then # Download 2k resolution av1 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -S "res:1440,vcodec:av1"
        	
        elif [[ "$resolution" =~ (4V1|4v1) ]]
        then # Download 4k resolution av1 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -S "res:2160,vcodec:av1"
        	
        
        elif [[ "$resolution" =~ (2P9|2p9) ]]
        then # Download 4k resolution vp9 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -S "res:1440,vcodec:vp9"
        
        elif [[ "$resolution" =~ (4p9|4P9) ]]
        then # Download 4k resolution vp9 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -S "res:2160,vcodec:vp9"
        
        
        else # Download 1080p resolution h264 video
            BeforeDownloadRoutine
            yt-dlp $youtubelink -S "res:1080,vcodec:h264"
        fi
    fi
    DownloadsDoneMessage
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

