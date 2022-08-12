# Define function to delete prerequisites
function DeletePrereq {Remove-Item ".\ffmpeg.zip" -Recurse -Force; Remove-Item ".\ffmpeg.exe" -Recurse -Force;}

# make sure your powershell command is in C:\User\<yourusername>

cls; # Clear terminal for a clean look

# Welcome ascii art
Write-Host "`n __      ________________    _________ ________     _____  ___________" -ForegroundColor Green;
Write-Host "/  \    /  \_   _____/   |   \_   ___ \\_____  \   /     \ \_   _____/" -ForegroundColor Green;
Write-Host "\   \/\/   /|    __)_|   |   /    \  \/ /   |   \ /  \ /  \ |    __)_ " -ForegroundColor Green;
Write-Host " \        / |        \   |___\     \____    |    \    \    \|        \" -ForegroundColor Green;
Write-Host "  \__/\  / /_______  /______ \\______  /_______  /____/\_  /_______  /" -ForegroundColor Green;
Write-Host "       \/          \/       \/       \/        \/        \/        \/`n" -ForegroundColor Green;

# Program intro
Write-Host "YouTube downloader one liner by Haizi Izzudin"+"Powered by yt-dlp and ffmpeg" -ForegroundColor Green;
Start-Sleep -Seconds 1;
Write-Host "`nAllow program to download prerequisites first (Prerequisites will be deleted once this session ends)" -ForegroundColor Yellow;

# Downloading and setup pre-requisites
Invoke-WebRequest -Uri https://github.com/HaiziIzzudin/ytdhaizi/releases/download/120822/ffmpeg.zip -OutFile .\ffmpeg.zip; ## Download ffmpeg win
Expand-Archive -LiteralPath ".\ffmpeg.zip" -DestinationPath ".\"; ## Extract ffmpeg.zip
Invoke-WebRequest -Uri https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile .\yt-dlp.exe; ## download yt-dlp from yt-dlp github

# Enter youtube url
Write-Host "";
$ytlink= Read-Host -Prompt "Enter YouTube URL";

# User chooses type
Write-Host "";
Write-Host "What kind of download do you want?" -ForegroundColor Green;
Write-Host "[A] Audio/Music (mp3)" -ForegroundColor Green;
Write-Host "[V] Video (webm/mp4)" -ForegroundColor Green;
Write-Host "Enter neither of the value to exit program (not case-sensitive)" -ForegroundColor Yellow;
$type= Read-Host -Prompt "Enter kind of download";
Write-Host "";

## If audio is selected
if ($type -eq "A") {write-host "Audio/Music selected. Downloading..." -ForegroundColor Green;
	./yt-dlp $ytlink -f "ba" -o "~/Desktop/%(title)s.%(ext)s";
	DeletePrereq;
    Write-Host "Thank you for using YTD Oneliner. Your Audio/Music is available in the Desktop. Program will now exit." -ForegroundColor Yellow;}

## else if video is selected
elseif ($type -eq "V") {write-host "Video selected. Downloading..." -ForegroundColor Green;
	./yt-dlp $ytlink -f "bv+ba" -o "~/Desktop/%(title)s.%(ext)s";
	DeletePrereq;
    Write-Host "Thank you for using YTD Oneliner. Your Video is available in the Desktop. Program will now exit." -ForegroundColor Yellow;}

## if neither of entered is valid
else {write-host "Non valid character. Program will now clear prerequisites and exit." -ForegroundColor Red; DeletePrereq;}



# Note to self
# Pipeline used to make continuous process, with referencing to the older parametes
# Semicolon used to make continuous process, without references to older parametes (command is onto itself)
