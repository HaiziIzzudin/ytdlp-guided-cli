function Header {
    Write-Host "        ===================================================" -ForegroundColor Green;
    Write-Host "         YOUTUBE DOWNLOADER GUIDED CLI BY HAIZI IZZUDIN" -ForegroundColor Green;
    Write-Host "         YOUR PLATFORM IS $platform. RUNNING $version" -ForegroundColor Green;
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
    elseif ($youtubelink -eq "C") {
        Clear-Host; Changelogs;
    }
    else {
        $choicemultiplelinks = Read-Host -Prompt "Is your downloads consists of multiple links? (many download links?)`n[y] Yes       [N] No (Default)";
        if ($choicemultiplelinks -eq "y") {
            LinksArray; }
        else {
            DownloadConfig; SingleVideo_DownloadCmd; DonwloadDone;}
    }
}

function DownloadConfig { # define function to download section
    Write-Host "`nPlease specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video." -ForegroundColor Green; 
    # User chooses type
    Write-Host "`n[N] Not from YouTube platform (may uses m3u8 method)" -ForegroundColor Green;
    $typeselection = Read-Host -Prompt "`n`nEnter type of download";
        
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
    }
}

function LinksArray {
    $arr = @();
    $arr += $youtubelink;
    while ($item -ne "END") {
        $lastarr_entrycount = $arr.Length;
        $item = Read-Host -Prompt "`nEnter in link for array number $lastarr_entrycount.`n`n(Write 'END' to end array list)";
        $arr += $item;
        Clear-Host; Header;
    }
    $arr;
}

# AV1 2k 400+140 | AV1 4k 401+140 | VP9 2k 271+251 | VP9 4k 313+251 | H264 1080 137+140

function SingleVideo_DownloadCmd {
    ./yt-dlp $youtubelink -S $videoid -o "~/Desktop/YouTube_Downloads/%(playlist_autonumber)d %(title)s %(vcodec)s_%(height)d.%(ext)s"; }

function MultiVideo_DownloadCmd {
    for ($i = 0; $i -lt $arr.Length; $i++;) {
        ./yt-dlp $arr[$arr.Length - 1] -S $videoid -o "~/Desktop/YouTube_Downloads/%(playlist_autonumber)d %(title)s %(vcodec)s_%(height)d.%(ext)s";
    }
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
    if ($platform -eq "WINDOWS") {
        Write-Host "`n`nChecking prerequisites..." -ForegroundColor Yellow;
        if ((Test-Path -Path "~\yt-dlp.exe") -eq $True) {
            Write-Host "`nYou already have the file required.`n" -ForegroundColor Green;  
        }
        else {
            Write-Host "`nYou don't have the required file.`nWe'll download it first." -ForegroundColor Yellow;
            RefreshPrereq;
        }
    }
    else {
        Write-Host "`n`nChecking prerequisites..." -ForegroundColor Yellow;
        if ((Test-Path -Path "~/yt-dlp") -eq $True) {
            Write-Host "`nYou already have the file required.`n" -ForegroundColor Green;  
        }
        else {
            Write-Host "`nYou don't have the required file.`nWe'll download it first." -ForegroundColor Yellow;
            RefreshPrereq;
        }
    }
}

function RefreshPrereq () {
    if ($platform -eq "WINDOWS") {
        Write-Host "Removing old executable module";
        if ((Test-Path -Path "~\ffmpeg.exe") -eq $True) {
            Remove-Item "~\ffmpeg.exe" -Recurse -Force; }
        if ((Test-Path -Path "~\yt-dlp.exe") -eq $True) {
            Remove-Item "~\yt-dlp.exe" -Recurse -Force; }
        Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip -OutFile ~\ffmpeg.zip; 
        # Download ffmpeg win64
	    Expand-Archive -LiteralPath "~\ffmpeg.zip" -DestinationPath "~\"; # Expand archive ffmpeg
        Remove-Item "~\ffmpeg.zip" -Recurse -Force; # Delete Archive after expansion
        Move-Item -Path C:\Users\haizi\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -Destination ~\; # Move ffmpeg.exe to home dir
        Remove-Item "~\ffmpeg-master-latest-win64-gpl\" -Recurse -Force; # Remove item ffmpeg directory
        Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile ~\yt-dlp.exe; # Now download yt-dlp executable
        Write-Host "`nPrerequisites downloads done!" -ForegroundColor Green; # Message downloads prereq done
    }
    else {
        Write-Host "Removing old linux binary module";
        if ((Test-Path -Path "~/ffmpeg") -eq $True) {
            Remove-Item "~/ffmpeg" -Recurse -Force; }
        if ((Test-Path -Path "~/yt-dlp") -eq $True) {
            Remove-Item "~/yt-dlp" -Recurse -Force; }
        Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz -OutFile ~/ffmpeg.tar.xz;
        # Download ffmpeg linux64
	    tar -xf ffmpeg.tar.xz; # Expand tarball
        Remove-Item "~/ffmpeg.tar.xz" -Recurse -Force; # Delete Archive after expansion
        Move-Item -Path ~/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg -Destination ~/; # Move ffmpeg.exe to home dir
        Remove-Item "~/ffmpeg-master-latest-linux64-gpl/" -Recurse -Force; # Remove item ffmpeg directory
        Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -OutFile ~/yt-dlp; # Now download yt-dlp executable
        chmod u+x ./yt-dlp; # set permission for current user to program be executable
        Write-Host "`nPrerequisites downloads done!" -ForegroundColor Green; # Message downloads prereq done
    }
}

function Changelogs {
    Write-Host "Changelogs $version";
    Write-Host "- There will be a function to input arrays of links, and while loops download all videos into a folder (require quality video set beforehand.)";
    Write-Host "Yeah this loks only one changelogs, but the code is super confusing, like I almost give up.";
    Pause; Clear-Host; MainMenu;
}

# Program actually starts here
if ((Test-Path -Path "C:\Windows\System32" -PathType Container) -eq $True) {
    $platform = "WINDOWS";
}
else {
    $platform = "LINUX";
} # platform checks

Clear-Host; Set-Location ~\;
$version= "VERSION 9";
Write-Host " __      ________________    _________ ________     _____  ___________" -ForegroundColor Green;
Write-Host "/  \    /  \_   _____/   |   \_   ___ \\_____  \   /     \ \_   _____/" -ForegroundColor Green;
Write-Host "\   \/\/   /|    __)_|   |   /    \  \/ /   |   \ /  \ /  \ |    __)_ " -ForegroundColor Green;
Write-Host " \        / |        \   |___\     \____    |    \    \    \|        \" -ForegroundColor Green;
Write-Host "  \__/\  / /_______  /______ \\______  /_______  /____/\_  /_______  /" -ForegroundColor Green;
Write-Host "       \/          \/       \/       \/        \/        \/        \/ " -ForegroundColor Green; 
MainMenu; # call function MainMenu

