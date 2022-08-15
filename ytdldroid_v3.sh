r="\e[31m"; g="\e[32m"; y="\e[33m"; e="\e[0m"; # color presets

DownloadsDoneMessage () {
    echo
    echo -e "${g}Downloads done. It should be in your Downloads folder.${e}"
    echo
    echo "Key in C to download more. Key in other to exit program."
    read -e -p "Option: " continueorabort
    echo

    if [[ "$continueorabort" =~ (C|c) ]]
    then # back to input yt url
        MainMenu
     
    else # exit program
        exit
    fi
}

BeforeDownloadRoutine () {
    bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)"; cd ..; cd ..; cd ..; cd ..; cd ..; cd sdcard; cd download;
}

OfferAV1 () {
    echo
    echo -e "${y}Do you want to download this resolution in AV1 codec?${e}"
    echo -e "${y}AV1 codec offers higher quality for a smaller file size. The downside is that you need a powerful CPU to decode AV1 video, and many devices still lacks support of AV1 decoding engine.${e}"
    echo
    read -e -p "Type 'Y' to proceed. Leave others/blank to reject: " wantav1
    echo
}

TypeNQualitySelectionSingleMedia () {
    echo
    echo -e "${y}Please specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video.${e}"
    echo -e "${y}(A) Audio Only${e}"
    echo -e "${y}(N) Non-YouTube Video${e}"
    echo
    read -e -p "Pick Your Poison: " typeselection
	
    if [[ "$typeselection" =~ (A|a) ]]
    then # Download audio only
        BeforeDownloadRoutine
        yt-dlp $youtubelink -f "ba" --recode-video mp3
        
    elif [[ "$typeselection" =~ (N|n) ]]
    then # Download max quality due to these platform dont separate video and audio.
        BeforeDownloadRoutine
        yt-dlp $youtubelink


    else # if leaving others/blank...
        echo
        echo -e "${y}Defaults (YouTube Video) selected. Please specify any of special resolution below. Leaving others/blank will defaulted to 1080p.${e}"
        echo
        echo -e "${y}(2K) 2560x1440 video${e}"
        echo -e "${y}(4K) 3840x2160 video${e}"
        read -e -p "Pick a resolution: " resolution
        echo
		

        if [[ "$resolution" =~ (2K|2k) ]]
        then # offer av1 in 2k
            OfferAV1;
            
            if [[ "$wantav1" =~ (Y|y) ]]
            then
                BeforeDownloadRoutine
                yt-dlp $youtubelink -S "res:1440,vcodec:av1"
            
            else
                BeforeDownloadRoutine
                yt-dlp $youtubelink -S "res:1440,vcodec:vp9"
            
            fi


        elif [[ "$resolution" =~ (4K|4k) ]]
        then # offer av1 in 4k
            OfferAV1;
            
            if [[ "$wantav1" =~ (Y|y) ]]
            then
                BeforeDownloadRoutine
                yt-dlp $youtubelink -S "res:2160,vcodec:av1"

            else
                BeforeDownloadRoutine
                yt-dlp $youtubelink -S "res:2160,vcodec:vp9"
            
            fi

        else # Defaulted 1080p resolution h264 video
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
    echo -e "${g}       ANDROID RELEASE CANDIDATE VERSION 3${e}"
    echo -e "${g}       POWERED BY YT-DLP, FFMPEG AND BASH${e}"
    echo -e "${g}       INSTALL SCRIPT BY lostb053 ON GITHUB${e}"
    echo -e "${g}      ======================================${e}"
    read -e -p "Paste YouTube URL: " youtubelink
    echo
    TypeNQualitySelectionSingleMedia;
}

MainMenu;

