# FUNCTIONS PRESETS
    
    function Header {Write-Host "=== YOUTUBE DOWNLOADER ONE-LINER BY HAIZI IZZUDIN: $version ==" -ForegroundColor Green; Write-Host "===== Powered by yt-dlp and ffmpeg (BtBn) || Available on github =====" -ForegroundColor Green;}
    
    function GotoFfmpeg {Set-Location ~\ffmpeg-master-latest-win64-gpl-shared\bin\;}
    
    function GotoYTFolder {Set-Location "~\Desktop\YouTube_Downloads\";}
    
    function Sleeping {Start-Sleep -Seconds 3;}

    $ResolutionDisclaimer= "Downloading $type video on highest quality...`nRemind ya that if the video don't have $type resolution, it will choose the highest quality available.`n`n"
    
    $DLNaming= "~/Desktop/YouTube_Downloads/%(playlist_autonumber)d_%(channel)s_%(title)s.%(ext)s"


# FUNCTION ACTIONS

# new mainmenu will directly greet you with inserting youtube url
function MainMenu {Set-Location ~\; 
    Header; 
    $youtubelink= Read-Host -Prompt "`nPaste YouTube URL";
	DownloadNow;
}

function DownloadNow { # define function to download section
    Write-Host ""
    Write-Host "`nPlease specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video.`n`n" -ForegroundColor Green; # User chooses type
    Write-Host "[A] Audio only (mp3)`n[N] Non-YouTube Video" -ForegroundColor Green;
    $typeselection= Read-Host -Prompt "`n`nEnter type of download";
        
    if ($typeselection -eq "A") {
        BeforeDownloadRoutine;
        Write-Host "Downloading Audio Only on highest quality...";
        ./yt-dlp $youtubelink -f "ba" --recode-video mp3 -o $DLNaming;
    }
    elseif ($typeselection -eq "N") {
        BeforeDownloadRoutine;
        Write-Host "Downloading Non-YouTube video...";
        ./yt-dlp $youtubelink
    }
    else {
        Write-Host "`nDefaults (YouTube Video) selected. Please specify any of special resolution below. Leaving others/blank will defaulted to 1080p.";
        Write-Host "`n[2K] 2560x1440 resolution video`n[4K] 3840x2160 resolution video";
        $typeselection= Read-Host -Prompt "`n`nPick a resolution";

        if ($typeselection -eq "2K") {
            OfferAV1;
            
            if ($wantav1 -eq "Y") {
                BeforeDownloadRoutine;
                ./yt-dlp $youtubelink -f 400+140 -o $DLNaming;
            }
            else {
                BeforeDownloadRoutine;
                ./yt-dlp $youtubelink -f 271+251 -o $DLNaming;
            }
        }
        elseif ($typeselection -eq "4K") {
            OfferAV1;
            
            if ($wantav1 -eq "Y") {
                BeforeDownloadRoutine;
                ./yt-dlp $youtubelink -f 401+140 -o $DLNaming;
            }
            else {
                BeforeDownloadRoutine;
                ./yt-dlp $youtubelink -f 313+251 -o $DLNaming;
            }
        }
        else {
            BeforeDownloadRoutine;
            ./yt-dlp $ytlink -S "res:1080,vcodec:h264" -o $DLNaming;
        }
    }
    DonwloadDone;
}

function OfferAV1 () {
    Write-Host ""
    Write-Host "Do you want to download this resolution in AV1 codec?"
    Write-Host "AV1 codec offers higher quality for a smaller file size. The downside is that you need a powerful CPU to decode AV1 video, and many devices still lacks support of AV1 decoding engine."
    Write-Host ""
    $wantav1= Read-Host -Prompt "`n`nType 'Y' to proceed. Leave others/blank to reject";
    Write-Host ""
}

function DonwloadDone () {
    Write-Host "`n`n`nDownload done! Video is available in Desktop\YouTube_Downloader\`n" -ForegroundColor Green;
    $returnhome= Read-Host -Prompt "[O] Show in Folder     [other_key] Return to Main Menu";
    if ($returnhome -eq "O") {
        Invoke-Item "~\Desktop\YouTube_Downloads\";
        Clear-Host; MainMenu;
    }
    else {
        Clear-Host; MainMenu;
    }
}

function BeforeDownloadRoutine {
    Write-Host "`n`nChecking prerequisites..." -ForegroundColor Yellow
    if ((Test-Path -Path "~\ffmpeg.zip") -eq $True) {
        Write-Host "`nYou already have the file required.`n" -ForegroundColor Green; GotoFfmpeg; 
    }
    else {
        Write-Host "`nYour computer don't have the required file to run.`nAllow program to download it first." -ForegroundColor DarkMagenta;
	    Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip -OutFile .\ffmpeg.zip; # Download ffmpeg win64
	    Expand-Archive -LiteralPath "~\ffmpeg.zip" -DestinationPath "~\"; # Extract ffmpeg.zip (renamed) archive
        GotoFfmpeg; 
        Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile .\yt-dlp.exe;
        #Downloaded yt-dlp.exe in the ffmpeg\bin folder
        Write-Host "`nPrerequisites downloads done!" -ForegroundColor Green;
    }
}

# Program actually starts here
Clear-Host; Set-Location ~\;
$version= "VERSION 6";
Write-Host " __      ________________    _________ ________     _____  ___________" -ForegroundColor Green;
Write-Host "/  \    /  \_   _____/   |   \_   ___ \\_____  \   /     \ \_   _____/" -ForegroundColor Green;
Write-Host "\   \/\/   /|    __)_|   |   /    \  \/ /   |   \ /  \ /  \ |    __)_ " -ForegroundColor Green;
Write-Host " \        / |        \   |___\     \____    |    \    \    \|        \" -ForegroundColor Green;
Write-Host "  \__/\  / /_______  /______ \\______  /_______  /____/\_  /_______  /" -ForegroundColor Green;
Write-Host "       \/          \/       \/       \/        \/        \/        \/ " -ForegroundColor Green; 
MainMenu; # call function MainMenu

# Changelogs (version 6)
# Streamlining functions to be similar with what get on android side like:
# greeting directly to paste youtube url
# removing encode mp4 via ffmpeg (1080p will be downloaded in h264 codec instead)
# pls encode 2k/4k webm video via ffmpeg using shutter encoder instead. This is simplify user experience goddamit.
# 720p option removal due to its low quality and everyone wnats hd quality nowadays, and 1080p is small in size now.
# (even if you have slow internet connection, you are downloading, not streaming)
# inserting other/blank will defaulted to download 1080p video. To cancel, pls enter in nonsesnse on youtube url instead OR exit the terminal.

# For those who opening this source code, here's some changelogs (VERSION 5)
# - Added new function to delete webm, organise webm into a folder, or let it unchanged.
# - Code has been cleaned for better viewing and diagnostics.
# - Prerequisite checking will now give a status "Checking required file..."
# - Naming scheme of video file has been changed. It's now (playlist_autonumber)(Channel_name)(video_id).(ext)
# - Fixed bugs where EncodeMp4 function will spit out 'finished' even though there is no webm file available in folder.
# - Change of function from Lobby to MainMenu.
# - Start-Sleep command has now been collected and condensed into a function/method.
# - Some folder location has been collected into a function for a lesser prone to typo.
# - Quality selection is now available, and
# - Downloads will auto drop to the highest available resolution if there isn't any specified.
# Thank you for using my app :) Your support is really grateful for me.
# Source code is always available on my pastebin (the link you just paste)
# Follow me on github (github.com/haiziizzudin)