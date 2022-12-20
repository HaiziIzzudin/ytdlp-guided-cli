r="\e[31m"; g="\e[32m"; y="\e[33m"; e="\e[0m"; # color presets


echo "Updating ytdlp for android...";


bash -c "$(curl -fsSL https://bit.ly/install-ytdl-termux)";
cd ..; cd ..; cd ..; cd ..; cd ..; cd sdcard; cd download;


# user input livedl
read -e -p "Enter in live URL: " yturl
read -e -p "Enter in game name: " gamename


# naming scheme
d=`date +%Y%m%d`; foldername="$d $gamename"; fnmod=${foldername:2};
echo $fnmod


# Check if file gameName already available. If not, create one. Then, cd into it.
if [[ -d "$fnmod" ]]
then
    cd $fnmod;
else
    mkdir "$fnmod"; cd "$fnmod";
fi


# yt-dlp command
yt-dlp $yturl -f bv*+ba --no-part --live-from-start --restrict-filenames