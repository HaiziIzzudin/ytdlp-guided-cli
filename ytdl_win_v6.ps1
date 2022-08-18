function Header {
    Write-Host "        ===================================================" -ForegroundColor Green;
    Write-Host "         YOUTUBE DOWNLOADER ONE-LINER BY HAIZI IZZUDIN" -ForegroundColor Green;
    Write-Host "         WINDOWS RELEASE CANDIDATE VERSION 6" -ForegroundColor Green;
    Write-Host "         POWERED BY YT-DLP AND FFMPEG, CODED IN POWERSHELL" -ForegroundColor Green;
    Write-Host "        ===================================================" -ForegroundColor Green;
    }

function MainMenu {Set-Location ~\; 
    Header; 
    $youtubelink= Read-Host -Prompt "`nPaste YouTube URL";
	DownloadNow;
}

function DownloadNow { # define function to download section
    Write-Host "`nPlease specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video." -ForegroundColor Green; 
    # User chooses type
    Write-Host "`n[A] Audio only (mp3)`n[N] Non-YouTube Video" -ForegroundColor Green;
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
        Write-Host "`nDefaults (YouTube Video) selected. Please specify any of special resolution below.";
        Write-Host "`nAV1 offers lower file size, but come in cost of high CPU usage (AV1 only available on select videos)";
        Write-Host "`n[2V1] 2560x1440 resolution AV1 codec`n[4V1] 3840x2160 resolution AV1 codec";
        Write-Host "`nVP9 offers bigger file size, but come at a cost of lower CPU usage.";
        Write-Host "`n[2P9] 2560x1440 resolution VP9 codec`n[4P9] 3840x2160 resolution VP9 codec";
        Write-Host "`nLeaving others/blank will defaulted to 1080p h264";
        $typeselection= Read-Host -Prompt "`nPick a resolution";

        if ($typeselection -eq "2V1") {
            $videoid="res:1440,vcodec:av1"
        }
        elseif ($typeselection -eq "4V1") {
            $videoid="res:2560,vcodec:av1"
        }
        elseif ($typeselection -eq "2P9") {
            $videoid="res:1440,vcodec:vp9"
        }
        elseif ($typeselection -eq "4P9") {
            $videoid="res:2560,vcodec:vp9"
        }
        else { #if blank/other, 1080 will be selected
            $videoid="res:1080,vcodec:h264"
        }
        BeforeDownloadRoutine;
        ./yt-dlp $youtubelink -S $videoid -o "~/Desktop/YouTube_Downloads/%(playlist_autonumber)d %(title)s %(vcodec)s_%(height)d.%(ext)s";
        #AV1 2k 400+140
        #AV1 4k 401+140
        #VP9 2k 271+251
        #VP9 4k 313+251
        #h264 1080 137+140
    }
    DonwloadDone;
}

function DonwloadDone () {
    Write-Host "`n`n`nDownload done! Video is available in Desktop\YouTube_Downloader\`n" -ForegroundColor Green;
    $returnhome= Read-Host -Prompt "If the above download process fails/buggy, you can reinstall package by`n[R] Reinstall/update prerequisites`n`nOtherwise:`n[P] Show in Folder`n[others/blank] Return to Main Menu";
    if ($returnhome -eq "O") {
        Invoke-Item "~\Desktop\YouTube_Downloads\";
        Clear-Host; MainMenu;
    }
    elseif ($returnhome -eq "R") {
        Write-Host "`n`nUpdating prerequisites..." -ForegroundColor Yellow;
        RefreshPrereq; Pause; Clear-Host; MainMenu;
    }
    else {
        Clear-Host; MainMenu;
    }
}

function BeforeDownloadRoutine {
    Write-Host "`n`nChecking prerequisites..." -ForegroundColor Yellow;
    if ((Test-Path -Path "~\ffmpeg-master-latest-win64-gpl-shared\bin\yt-dlp.exe") -eq $True) {
        Write-Host "`nYou already have the file required.`n" -ForegroundColor Green; 
        Set-Location ~\ffmpeg-master-latest-win64-gpl-shared\bin\; 
    }
    else {
        Write-Host "`nYour computer don't have the required file to run.`nAllow program to download it first." -ForegroundColor DarkMagenta;
	    RefreshPrereq;
    }
}

function RefreshPrereq () {
    # if statements to delete (this to avoid erroring on client side)
    if ((Test-Path -Path "~\ffmpeg.zip") -eq $True) {
        Write-Host "Removing ffmpeg.zip";
        Remove-Item "~\ffmpeg.zip" -Recurse -Force;
    }
    if ((Test-Path -Path "~\ffmpeg-master-latest-win64-gpl-shared\bin\yt-dlp.exe") -eq $True) {
        Write-Host "Removing yt-dlp and ffmpeg folder";
        Remove-Item "~\ffmpeg-master-latest-win64-gpl-shared\" -Recurse -Force;
    }
    #Change directory to home
    Set-Location ~\;
    # Download ffmpeg win64
    Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip -OutFile .\ffmpeg.zip; 
	# Extract ffmpeg.zip archive
    Expand-Archive -LiteralPath "~\ffmpeg.zip" -DestinationPath "~\"; 
    # Change active directory to extracted
    Set-Location ~\ffmpeg-master-latest-win64-gpl-shared\bin\;
    # Now download yt-dlp binary
    Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile .\yt-dlp.exe;
    # Delete remaining ffmpeg.zip (we dont need it anymore)
    Remove-Item "~\ffmpeg.zip" -Recurse -Force;
    # Message downloads prereq done
    Write-Host "`nPrerequisites downloads done!" -ForegroundColor Green;
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
# inserting other/blank will defaulted to download 1080p video. To cancel, pls exit the terminal.