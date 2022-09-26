function MainMenu { Header; 
    $arr = ""; 
    Write-Host "Key in`n[C] View Changelogs"
    $youtubelink= Read-Host -Prompt "`nOtherwise, Paste YouTube URL here";
    if ($youtubelink -eq "C") {
        Clear-Host; Changelogs;
    }
    else {
        $arr = @(); $arr += $youtubelink;
        while ($item -ne "END") {
            $lastarr_entrycount = $arr.Length + 1;
            $item = Read-Host -Prompt "`nEnter in link for slot number $lastarr_entrycount.`n`n(Write 'END' to end list)";
            $arr += $item; Clear-Host; Header;
        }
        Write-Host "`nPlease specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video.`n`n[N] Not from YouTube platform (may uses m3u8 method)" -ForegroundColor Green; 
        $typeselection = Read-Host -Prompt "`nEnter type of download";
        if ($typeselection -eq "N") {
            BeforeDownloadRoutine;
            Write-Host "Downloading Non-YouTube video. Plesae be patient...";
            foreach ($onelinkarr in $arr) {
                $i = $i + 1; 
                $amountfinished = "$i" + "/" + $arr.Length;
                Write-Host "[$amountfinished] ./yt-dlp $onelinkarr -f bv*+ba/b -P ~/Desktop/YouTube_Downloads/`n";
                yt-dlp $onelinkarr -f "bv*+ba/b" --restrict-filenames -P ~/Desktop/YouTube_Downloads/; 
            } 
            DonwloadDone;
        }
        else {
            Write-Host "`nDefaults (YouTube Video) selected. Please specify quality...`n`n1080p (default) will be downloaded in H264 codec`n2K will download in VP9 codec`n4K video will be downloaded in AV1 codec";
            $typeselection= Read-Host -Prompt "`nPlease type 2K OR 4K, or leave others/blank to download 1080p";
            if ($typeselection -eq "2K") {
                $videoid = "271+251"; Write-Host $videoid;
            }
            elseif ($typeselection -eq "4K") {
                $videoid = "401+140"; Write-Host $videoid;
            }
            else { #if blank/other, 1080 will be selected
                $videoid = "137+140/b"; Write-Host $videoid;
            }
            BeforeDownloadRoutine; Write-Host "Download has started. Please be patient...";
            foreach ($onelinkarr in $arr) {
                $i = $i + 1; 
                $amountfinished = "$i" + "/" + $arr.Length;
                Write-Host "[$amountfinished] ./yt-dlp $onelinkarr -f $videoid -P ~/Desktop/YouTube_Downloads/`n";
                yt-dlp $onelinkarr -f $videoid --restrict-filenames -P ~/Desktop/YouTube_Downloads/;
            } 
            DonwloadDone;
        }
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
        if ((Test-Path -Path "~\AppData\Local\Microsoft\WindowsApps\yt-dlp.exe")  -and (Test-Path -Path "~\AppData\Local\Microsoft\WindowsApps\ffmpeg.exe") -and  
            (Test-Path -Path "~\AppData\Local\Microsoft\WindowsApps\ffprobe.exe") -eq $True) { 
            Write-Host "`nYou already have the file required.`n" -ForegroundColor Green; }
        else {
            Write-Host "`nYou don't have the required file.`nWe'll download it first." -ForegroundColor Yellow;
            Write-Host "Removing old executable module";
            Set-Location ~\AppData\Local\Microsoft\WindowsApps;                                                                # CD TO PATHABLE
            if ((Test-Path -Path .\ffmpeg.exe) -eq $True) { Remove-Item .\ffmpeg.exe -Recurse -Force; }                        # REMOVE FFMPEG.EXE IF EXISTS
            if ((Test-Path -Path .\yt-dlp.exe) -eq $True) { Remove-Item .\yt-dlp.exe -Recurse -Force; }                        # REMOVE YT-DLP.EXE IF EXISTS
            Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip -OutFile .\ffmpeg.zip; 
	        Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile .\yt-dlp.exe; # DOWNLOAD YT-DLP EXECUTABLE
            Expand-Archive -LiteralPath ".\ffmpeg.zip" -DestinationPath ".\";                                                  # EXPAND ARCHIVE FFMPEG.EXE
            Move-Item -Path .\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -Destination .\;                                   # TAKEOUT FFMPEG.EXE TO PATHABLE
            Move-Item -Path .\ffmpeg-master-latest-win64-gpl\bin\ffprobe.exe -Destination .\;                                  # TAKEOUT FFPROBE.EXE TO PATHABLE
            Remove-Item ".\ffmpeg.zip" -Recurse -Force;                                                                        # DELETE THE ARCHIVE AFTER EXPANSION
            Remove-Item ".\ffmpeg-master-latest-win64-gpl\" -Recurse -Force;                                                   # REMOVE FFMPEG-MASTER DIRECTORY
            Write-Host "`nPrerequisites downloads for windows done!" -ForegroundColor Green;                                   # PRINT MESSAGE DOWNLOAD PREREQ DONE
        }
    }
    else {
        Write-Host "`n`nChecking prerequisites..." -ForegroundColor Yellow;
        if ((Test-Path -Path "~/yt-dlp") -eq $True) {
            Write-Host "`nYou already have the file required.`n" -ForegroundColor Green; }
        else {
            Write-Host "`nYou don't have the required file.`nWe'll download it first." -ForegroundColor Yellow;
            Write-Host "Removing old linux binary module";
            if ((Test-Path -Path "~/ffmpeg") -eq $True) { Remove-Item "~/ffmpeg" -Recurse -Force; }
            if ((Test-Path -Path "~/yt-dlp") -eq $True) { Remove-Item "~/yt-dlp" -Recurse -Force; }
            Invoke-WebRequest -Uri https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz -OutFile ~/ffmpeg.tar.xz; # Download ffmpeg linux64
	        tar -xf ffmpeg.tar.xz; # Expand tarball
            Remove-Item "~/ffmpeg.tar.xz" -Recurse -Force; # Delete Archive after expansion
            Move-Item -Path ~/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg -Destination ~/; # Move ffmpeg.exe to home dir
            Remove-Item "~/ffmpeg-master-latest-linux64-gpl/" -Recurse -Force; # Remove item ffmpeg directory
            Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -OutFile ~/yt-dlp; # Now download yt-dlp executable
            chmod u+x ./yt-dlp; # set permission for current user to program be executable
            Write-Host "`nPrerequisites downloads done!" -ForegroundColor Green; # Message downloads prereq done 
        }
    }
}
function Changelogs {
    Write-Host "Changelogs $version";Write-Host "- Code is redesigned, now ffmpeg and ffprobe binary will be in PATH instead, so if you want to use ffmpeg standalone, you can.`nAs of right now, above only applies to windows, but linux very soon. V11 mybe.";Pause; Clear-Host; MainMenu; }

function Header {
    Write-Host " YOUTUBE DOWNLOADER GUIDED CLI BY HAIZI IZZUDIN - YOUR PLATFORM IS $platform " -ForegroundColor Green;
    Write-Host " POWERED BY YT-DLP AND FFMPEG, CODED IN POWERSHELL - RUNNING $version" -ForegroundColor Green;
    Write-Host "=============================================================================" -ForegroundColor Green; }

Clear-Host; Set-Location ~\; # Program actually starts here
$version= "VERSION 10";
Write-Host " __      ________________    _________ ________     _____  ___________" -ForegroundColor Green;
Write-Host "/  \    /  \_   _____/   |   \_   ___ \\_____  \   /     \ \_   _____/" -ForegroundColor Green;
Write-Host "\   \/\/   /|    __)_|   |   /    \  \/ /   |   \ /  \ /  \ |    __)_ " -ForegroundColor Green;
Write-Host " \        / |        \   |___\     \____    |    \    \    \|        \" -ForegroundColor Green;
Write-Host "  \__/\  / /_______  /______ \\______  /_______  /____/\_  /_______  /" -ForegroundColor Green;
Write-Host "       \/          \/       \/       \/        \/        \/        \/ " -ForegroundColor Green; 
if ((Test-Path -Path "C:\Windows\System32" -PathType Container) -eq $True) { $platform = "WINDOWS"; }
else { $platform = "LINUX"; } # platform checks
MainMenu;