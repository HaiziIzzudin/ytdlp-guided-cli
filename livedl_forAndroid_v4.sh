r="\e[31m"; g="\e[32m"; y="\e[33m"; e="\e[0m"; # color presets


echo "Updating ytdlp for android...";


bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)";
cd ..; cd ..; cd ..; cd ..; cd ..; cd sdcard; cd download;


# user input livedl
read -e -p "Enter in live URL: " yturl
read -e -p "Enter in game name: " gamename


# naming scheme
d=`date +%Y%m%d`; foldername="$d $gamename";


# Check if file gameName already available. If not, create one. Then, cd into it.
if [[ -d "$foldername" ]]
then
    cd $foldername;
else
    mkdir "$foldername"; cd "$foldername";
fi