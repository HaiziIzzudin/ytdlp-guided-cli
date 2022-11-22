function MainMenu { Header; 
    $arr = ""; 
    Write-Host "Key in`n[C] View Changelogs"
    $youtubelink= Read-Host -Prompt "`nOtherwise, Paste YouTube URL here";
    if ($youtubelink -eq "C") {
        Clear-Host; Changelogs;
    }
    else {
        $arr = @();                                 # create new empty array
        $arr += $youtubelink;                       # add new inputted youtube link into array
        while ($item -ne "END") {                   # while loop item is NOT equal to END (non-case)
            $lastarr_entrycount = $arr.Length + 1;  # add 1 to the lastarr_entrycount to be displayed in next message 
            $item = Read-Host -Prompt "`nEnter in link for slot number $lastarr_entrycount.`n`n(Write 'END' to end list)";
            $arr += $item; Clear-Host; Header;      # ask user to input next ytlink, and add item to the array
        }   # if END is detected...


        Write-Host "`nPlease specify any specialty of this download. Leaving others/blank will defaulted to download YouTube Video.`n`n[N] Not from YouTube platform (may uses m3u8 method)" -ForegroundColor Green; 
        $typeselection = Read-Host -Prompt "`nEnter type of download";

        
        if ($typeselection -eq "N") {
            BeforeDownloadRoutine;
            Write-Host "Downloading Non-YouTube video. Plesae be patient...";
            foreach ($onelinkarr in $arr) {
                Invoke-Expression -Command "yt-dlp $onelinkarr -f "bv*+ba/b" --restrict-filenames -P ~/Desktop/YouTube_Downloads/"; 
            } 
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
            
            $askEmbedSubs = Read-Host -Prompt "`n`nEmbed subtitle?`n`n[Y] Yes       [N] No"

            BeforeDownloadRoutine; Write-Host "Download has started. Please be patient...";
            foreach ($onelinkarr in $arr) {
                if ($askEmbedSubs -eq "N") {
                    Invoke-Expression -Command "yt-dlp $onelinkarr -f $videoid --restrict-filenames -P ~/Desktop/YouTube_Downloads/";
                }
                else {
                    Invoke-Expression -Command "yt-dlp $onelinkarr -f $videoid --restrict-filenames --write-subs --write-auto-subs --embed-subs --sub-langs all -P ~/Desktop/YouTube_Downloads/";
                }
            }
        }
        Write-Host "Download done!"; Invoke-Item "~\Desktop\YouTube_Downloads\"; MainMenu;
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
        Write-Host "Linux has been deprecated and removed. New program will be written to replace linux binary update method. Wait for v11.`n`nSorry for inconvenience. You can now exit." -ForegroundColor Red;
    }
}
function Changelogs {
    Write-Host "Changelogs $version";
    Write-Host "- Code is redesigned, now ffmpeg and ffprobe binary will be in PATH instead, so if you want to use ffmpeg standalone, you can."
    Write-Host "- OLD Linux binary install and uninstall has been deprecated and removed. New method will be introduced in v11 instead.";
    Pause; Clear-Host; MainMenu; }

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