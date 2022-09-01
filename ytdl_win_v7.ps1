function Header {
    Write-Host "        ===================================================" -ForegroundColor Green;
    Write-Host "         YOUTUBE DOWNLOADER ONE-LINER BY HAIZI IZZUDIN" -ForegroundColor Green;
    Write-Host "         WINDOWS RELEASE $version" -ForegroundColor Green;
    Write-Host "         POWERED BY YT-DLP AND FFMPEG, CODED IN POWERSHELL" -ForegroundColor Green;
    Write-Host "        ===================================================" -ForegroundColor Green;
    }

function MainMenu {Set-Location ~\; 
    Header; 
    Write-Host "Key in`n[R] to reinstall/update prerequisites`n[C] View Changelogs"
    $youtubelink= Read-Host -Prompt "`nOtherwise, Paste YouTube URL here";
	
    if ($youtubelink -eq "R") {
        RefreshPrereq; Clear-Host; MainMenu;
    }
    if ($youtubelink -eq "C") {
        Clear-Host; Changelogs;
    }
    else {DownloadNow;}
}

function DownloadNow { # define function to download section
    Write-Host "`nPlease specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video." -ForegroundColor Green; 
    # User chooses type
    Write-Host "`n[N] Not from YouTube platform (may uses m3u8 method)" -ForegroundColor Green;
    $typeselection= Read-Host -Prompt "`n`nEnter type of download";
        
    if ($typeselection -eq "N") {
        BeforeDownloadRoutine;
        Write-Host "Downloading Non-YouTube video...";
        ./yt-dlp $youtubelink -f "bv*+ba"
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
        # AV1 2k 400+140 | AV1 4k 401+140 | VP9 2k 271+251 | VP9 4k 313+251 | H264 1080 137+140
    }
    DonwloadDone;
}

function DonwloadDone () {
    Write-Host "`n`n`nDownload done! Video is available in Desktop\YouTube_Downloader\`n" -ForegroundColor Green;
    $returnhome= Read-Host -Prompt "`n[P] Show in Folder`n[others/blank] Return to Main Menu";
    if ($returnhome -eq "P") {
        Invoke-Item "~\Desktop\YouTube_Downloads\";
        Clear-Host; MainMenu;
    }
    else {
        Clear-Host; MainMenu;
    }
}

function BeforeDownloadRoutine {
    Write-Host "`n`nChecking prerequisites..." -ForegroundColor Yellow;
    if ((Test-Path -Path "~\yt-dlp.exe") -eq $True) {
        Write-Host "`nYou already have the file required.`n" -ForegroundColor Green;  
    }
    else {
        Write-Host "`nYou don't have the required file.`nWe'll download it first." -ForegroundColor Yellow;
	    RefreshPrereq;
    }
}

function RefreshPrereq () {
    Write-Host "Removing old module";
    # if statements to delete (this to avoid erroring on client side)
    if ((Test-Path -Path "~\ffmpeg.exe") -eq $True) {
        Remove-Item "~\ffmpeg.exe" -Recurse -Force;
    }
    if ((Test-Path -Path "~\yt-dlp.exe") -eq $True) {
        Remove-Item "~\yt-dlp.exe" -Recurse -Force;
    }
    Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip -OutFile ~\ffmpeg.zip; # Download ffmpeg win64
	Expand-Archive -LiteralPath "~\ffmpeg.zip" -DestinationPath "~\"; # Download ffmpeg win64
    # Delete Archive after expansion
    Remove-Item "~\ffmpeg.zip" -Recurse -Force;
    # Move ffmpeg.exe to home dir
    Move-Item -Path C:\Users\haizi\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -Destination ~\;
    # Remove item ffmpeg directory
    Remove-Item "~\ffmpeg-master-latest-win64-gpl\" -Recurse -Force;
    # Now download yt-dlp binary
    Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile ~\yt-dlp.exe;
    # Message downloads prereq done
    Write-Host "`nPrerequisites downloads done!" -ForegroundColor Green;
}

function Changelogs {
    Write-Host "Changelogs $version"
    Write-Host "- Prerequisites installation has been rewrite, to only inflate ffmpeg and nothing else."
    Write-Host "- ytdlp and ffmpeg module will be placed to home directory now. No more going inside directory."
    Write-Host "- Audio downloads integration right now has been removed (its not reliable),"
    Write-Host "- Music downloads will be replaced with spotify-dl module instead, coming in version 8. Stay tuned."
    Write-Host "- All process location will be done inside home directory."
    Pause; Clear-Host; MainMenu;
}

# Program actually starts here
Clear-Host; Set-Location ~\;
$version= "VERSION 7";
Write-Host " __      ________________    _________ ________     _____  ___________" -ForegroundColor Green;
Write-Host "/  \    /  \_   _____/   |   \_   ___ \\_____  \   /     \ \_   _____/" -ForegroundColor Green;
Write-Host "\   \/\/   /|    __)_|   |   /    \  \/ /   |   \ /  \ /  \ |    __)_ " -ForegroundColor Green;
Write-Host " \        / |        \   |___\     \____    |    \    \    \|        \" -ForegroundColor Green;
Write-Host "  \__/\  / /_______  /______ \\______  /_______  /____/\_  /_______  /" -ForegroundColor Green;
Write-Host "       \/          \/       \/       \/        \/        \/        \/ " -ForegroundColor Green; 
MainMenu; # call function MainMenu

