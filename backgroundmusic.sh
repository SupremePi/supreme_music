#!/bin/bash

infobox= ""
infobox="${infobox}_______________________________________________________\n\n"
infobox="${infobox}\n"
infobox="${infobox}RetroPie Background Music Script\n\n"
infobox="${infobox}The mpg123 background music script has already been installed on this base image.\n"
infobox="${infobox}\n"
infobox="${infobox}This script will play MP3 files during menu navigation in either Emulationstation or Attract mode.\n"
infobox="${infobox}\n"
infobox="${infobox}A special new folder has been created in the /roms directory called \"music & music adult\" for placing your MP3 files into.\n"
infobox="${infobox}\n"
infobox="${infobox}Once you place your music files into this folder and enable it, the music will automatically begin playing.\n"
infobox="${infobox}\n"
infobox="${infobox}When you launch a game, however, the music will stop if you choose this.  Upon exiting out of the game the music will begin playing again if you have it set this way.\n"
infobox="${infobox}\n\n"

dialog --backtitle "Supreme RetroPie Background Music V2.0" \
--title "Supreme RetroPie Background Music v2.0" \
--msgbox "${infobox}" 35 110

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Music Play-Pause ($music_play_pause)" \
            2 "Startup Music On-Off At Boot ($music_at_boot)" \
            3 "Continue Music Over Game On-Off ($music_over_games)" \
            4 "Adult Music On-Off ($music_adult)" \
            5 "volume Menu (Sound set to $level)" \
            6 "Info" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) music_play_pause_on_off  ;;
            2) music_at_boot_on_off  ;;
            3) music_over_game_on_off  ;;
            4) music_adult_on_off  ;;
            5) volume_menu  ;;
            6) info  ;;
            *)  break ;;
        esac
    done
}

function music_play_pause_on_off() {
if [ $(cat /home/pi/music_settings/music_play_pause.flag) == "0" ]
then
        echo -e "$(tput setaf 2)Music Was Pasused But Now Playing! $(tput sgr0)"
        sleep 3
        pkill -CONT mpg123
        echo "1" > /home/pi/music_settings/music_play_pause.flag
        echo -e "$(tput setaf 2)Done! $(tput sgr0)"
        sleep 3
        clear
else
	echo -e "$(tput setaf 2)Music Was Playing But Now Pauseing! $(tput sgr0)"
        sleep 3
        pkill -STOP mpg123
        echo "0" > /home/pi/music_settings/music_play_pause.flag
        echo -e "$(tput setaf 2)Done! $(tput sgr0)"
        sleep 3
        clear
fi
}



function music_at_boot_on_off() {
if [ $(cat /home/pi/music_settings/music_at_boot.flag) == "0" ]
then
       echo -e "$(tput setaf 2)Music Was Off At Boot But Will Now Start At Boot up! $(tput sgr0)"
       sleep 3
       echo "1" > /home/pi/music_settings/music_at_boot.flag
       #exit 0
       echo -e "$(tput setaf 2)Done! Now Rebooting To Save Changes $(tput sgr0)"
       sleep 3
       sudo reboot
else
       echo -e "$(tput setaf 2)Music Was On At Start But Will Now Stop At Boot up! $(tput sgr0)"
       sleep 3
       echo "0" > /home/pi/music_settings/music_at_boot.flag
       #exit 0
       echo -e "$(tput setaf 2)Done! Now Rebooting To Save Changes $(tput sgr0)"
       sleep 3
       sudo reboot
fi
}


function music_over_game_on_off() {
if [ $(cat /home/pi/music_settings/music_over_games.flag) == "0" ]
then
       echo -e "$(tput setaf 2)Music Over Games Was Off But Will Now Play when A game Launches! $(tput sgr0)"
       sleep 3
       echo "1" > /home/pi/music_settings/music_over_games.flag
       #exit 0
       echo -e "$(tput setaf 2)Done! $(tput sgr0)"
       sleep 3
       clear
else
       echo -e "$(tput setaf 2)Music Over Games Was On But Will Now Stop Playing when A game Launches! $(tput sgr0)"
       sleep 3
       echo "0" > /home/pi/music_settings/music_over_games.flag
       #exit 0
       echo -e "$(tput setaf 2)Done! $(tput sgr0)"
       sleep 3
       clear
fi
}


function music_adult_on_off() {
if [ $(cat /home/pi/music_settings/music_adult.flag) == "0" ]
then
       echo -e "$(tput setaf 2)Adult Music Was Off But Now Its On! $(tput sgr0)"
       sleep 3
       echo "1" > /home/pi/music_settings/music_adult.flag
       #exit 0
       echo -e "$(tput setaf 2)Done! Now Rebooting To Save Changes $(tput sgr0)"
       sleep 3
       sudo reboot
else
       echo -e "$(tput setaf 2)Adult Music Now On But Now Its Off! $(tput sgr0)"
       sleep 3
       echo "0" > /home/pi/music_settings/music_adult.flag
       #exit 0
       echo -e "$(tput setaf 2)Done! Now Rebooting To Save Changes $(tput sgr0)"
       sleep 3
       sudo reboot
fi
}



function info() {
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo "                                    ,---------------------------.             "
echo -e "                           ...      |     ${GREEN} Build Date: 2022 ${NC}    |   ...       "
echo "                          (o o)     \`---------------------------'  (. .)     "
echo "                     -ooO--(_)--Ooo----------------------------ooO--(_)--Ooo- "
echo
echo -e "${GREEN}"
echo "                             SUPREME TEAM BACKGROUND MUSIC SCRIPT"
echo
echo -e "${NC}"
echo
echo
echo "				-- M U S I C  S E T T I N G S --"
echo
echo
echo -e "				              Adult Music:"   ${GREEN}$adult_music${NC}
echo -e "			 	    Start Music At Bootup:"   ${GREEN}$music_start${NC}
echo -e -n "			Continue Playing Music Over Games:"   ${GREEN}$music_over_games${NC}
echo "  (Caution: EXPERIMENTAL. May cause instability)"
echo
echo
echo -n "	  			9.."
sleep 1
echo -n "8.."
sleep 1
echo -n "7.."
sleep 1
echo -n "6.."
sleep 1
echo -n "5.."
sleep 1
echo -n "4.."
sleep 1
echo -n "3.."
sleep 1
echo -n "2.."
sleep 1
echo -n "1.."
sleep 1
echo -n ":)"
}


function volume_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " VOLUME MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Volume background music: 100%" \
            2 "Volume background music: 75%" \
            3 "Volume background music: 50%" \
            4 "Volume background music: 25%" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) volume100  ;;
            2) volume75  ;;
            3) volume50  ;;
            4) volume25  ;;
            *)  break ;;
        esac
    done
}

#mpg123 player volume 
#100 percent = 32768
#75 percent = 24576
#50 percent = 16384
#25 percent = 8192
#mpg123 -f 16384

if [ $(cat /home/pi/music_settings/music_adult.flag) == "0" ]
then
        input=music-clean
else
	input=music-adult
fi

function volume100() {
dialog --infobox "...processing..." 3 20 ; sleep 2
pkill -STOP mpg123
sed -i -E 's/mpg123 -f [0-9]+/mpg123 -f 32768/g' /opt/retropie/configs/all/autostart.sh
mpg123 -f 32768 -Z /home/pi/RetroPie/roms/music/$input/*.mp3 >/dev/null 2>&1 &
}

function volume75() {
dialog --infobox "...processing..." 3 20 ; sleep 2
pkill -STOP mpg123
sed -i -E 's/mpg123 -f [0-9]+/mpg123 -f 24576/g' /opt/retropie/configs/all/autostart.sh
mpg123 -f 24576 -Z /home/pi/RetroPie/roms/music/$input/*.mp3 >/dev/null 2>&1 &
}

function volume50() {
dialog --infobox "...processing..." 3 20 ; sleep 2
pkill -STOP mpg123
sed -i -E 's/mpg123 -f [0-9]+/mpg123 -f 16384/g' /opt/retropie/configs/all/autostart.sh
mpg123 -f 16384 -Z /home/pi/RetroPie/roms/music/$input/*.mp3 >/dev/null 2>&1 &
}

function volume25() {
dialog --infobox "...processing..." 3 20 ; sleep 2
pkill -STOP mpg123
sed -i -E 's/mpg123 -f [0-9]+/mpg123 -f 8192/g' /opt/retropie/configs/all/autostart.sh
mpg123 -f 8192 -Z /home/pi/RetroPie/roms/music/$input/*.mp3 >/dev/null 2>&1 &
}

############
#Admin List#
############

RED='\033[0;31m'
GREEN='\033[0;32m'
YEL='\033[1;33m'
NC='\033[0m'        #No Color


AUTOSTART="/opt/retropie/configs/all/autostart.sh"

    if grep -q '32768' "$AUTOSTART"; then
    level="100%"
  
    elif grep -q '24576' "$AUTOSTART"; then
    level="75%"
  
    elif grep -q '16384' "$AUTOSTART"; then
    level="50%"
   
    elif grep -q '8192' "$AUTOSTART"; then
    level="50%"
    fi

music_play_pause=$(cat /home/pi/music_settings/music_play_pause.flag)
music_adult=$(cat /home/pi/music_settings/music_adult.flag)
music_at_boot=$(cat /home/pi/music_settings/music_at_boot.flag)
music_over_games=$(cat /home/pi/music_settings/music_over_games.flag)


if [ $music_play_pause == "1" ]
then
	music_play_pause="PLAYING"
else
	music_play_pause="PAUSED"
fi

if [ $music_adult == "1" ]
then
	music_adult="On"
else
	music_adult="OFF"
fi

if [ $music_at_boot == "1" ]
then
	music_at_boot="ON"
else
	music_at_boot="OFF"
fi

if [ $music_over_games == "1" ]
then
        music_over_games="ON"
else
        music_over_games="OFF"
fi

main_menu
