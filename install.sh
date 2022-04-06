#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
clear

start_menu(){
    echo "Big Thanks to installtekz, Fuxxy Peach & David Marti"
    echo "New Layout Code by the Supreme Team supremeretrogaming.com"
    echo
    echo "Script version: 2.0"
    echo "Tested on RetroPie version: 4.7.1"
    echo
    echo
    echo
    echo
    echo "If you mount an external USB drive with ROMS etc. (\"retropie-mount\" directory on USB root) then make sure it's plugged in before booting up the Pi and running this script."
    echo
    echo
    echo "#-----------------------------------------------------------------------------------------------------------------------------------------------#"
    echo "#   DISCLAIMER:"
    echo "#   I will not take any responsability for any loss that this script may do. By using this script you take full responsability for your actions!"
    echo "#   If you make regular backups of your Pi image (and you should be!) then now would be a good time to do so."
    echo "#-----------------------------------------------------------------------------------------------------------------------------------------------#"
    echo
    echo
    sleep 10
    standard_setup
}

standard_setup()
{
        # check for an internet connection
        wget -q --spider http://google.com
        if [ $? -eq 0 ]; then
                if [ ! -d /home/pi/RetroPie/roms/music ]; then
                    mkdir /home/pi/RetroPie/roms/music
                fi

                if [ ! -d /home/pi/RetroPie/roms/music/music-adult ]; then
                    mkdir /home/pi/RetroPie/roms/music/music-adult
                fi

                if [ ! -d /home/pi/RetroPie/roms/music/music-clean ]; then
                    mkdir /home/pi/RetroPie/roms/music/music-clean
                fi

                if [ -f /home/pi/RetroPie/roms/music/*.mp3 ]; then
                    echo -e "$(tput setaf 2)Backing Up Your Old Music To Music-Clean! $(tput sgr0)"
                    sleep 3
                    mv /home/pi/RetroPie/roms/music/* /home/pi/RetroPie/roms/music/music-clean
                fi

                if [ ! -d /home/pi/music_settings ]; then
                    mkdir /home/pi/music_settings
                fi

                echo "1" > /home/pi/music_settings/music_at_boot.flag
                echo "1" > /home/pi/music_settings/music_adult.flag
                echo "0" > /home/pi/music_settings/music_over_games.flag
                echo "1" > /home/pi/music_settings/music_play_pause.flag
                echo "1" > /home/pi/music_settings/music_switch.flag
    
filefound11=`cat /opt/retropie/configs/all/autostart.sh |grep Supreme-Music |wc -l`
if [[ ${filefound11} > 0 ]]; then

   echo -e "$(tput setaf 2)Music Script Already Found in Outo Start But Will Now Enable! $(tput sgr0)"
   echo "already in autostart.sh" > /tmp/exists
   pkill -CONT mpg123
   echo "1" > /home/pi/music_settings/music_switch.flag

else

filefound=`cat /opt/retropie/configs/all/autostart.sh |grep mpg123 |wc -l`
if [[ ${filefound} > 0 ]]; then

   echo -e "$(tput setaf 2)Found An Old Version Of Mpg123 Installed Removing It And Installing The Supreme Version! $(tput sgr0)"
   sleep 3      
   cp /opt/retropie/configs/all/autostart.sh /opt/retropie/configs/all/autostart.sh.bkp
   sed -i '/while pgrep omxplayer/d' /opt/retropie/configs/all/autostart.sh
   sed -i '/(sleep 10; mpg123/d' /opt/retropie/configs/all/autostart.sh

cat <<\EOF123 > "/tmp/templist"
#Adult Music On Or Off
if [ $(cat /home/pi/music_settings/music_adult.flag) == "0" ]
then
        input=music-clean
else
	input=music-adult
fi

#Supreme-Music
if [ $(cat /home/pi/music_settings/music_at_boot.flag) == "0" ]
then
	pkill -STOP mpg123
else
       while pgrep omxplayer > /dev/null; do sleep 1; done
       (sleep 10; mpg123 -f 32768 -Z /home/pi/RetroPie/roms/music/$input/*.mp3 >/dev/null 2>&1) &
       #Resets Manually Switched 
       echo "1" > /home/pi/music_settings/music_switch.flag
fi
EOF123
sed -i -f - /opt/retropie/configs/all/autostart.sh < <(sed 's/^/1i/' /tmp/templist)

echo -e "$(tput setaf 2)Done! $(tput sgr0)"
sleep 3
clear

else

echo -e "$(tput setaf 2)Now Installing The Supreme Version of Mpg123! $(tput sgr0)"
sleep 3    
cp /opt/retropie/configs/all/autostart.sh /opt/retropie/configs/all/autostart.sh.bkp
cat <<\EOF123 > "/tmp/templist"
#Adult Music On Or Off
if [ $(cat /home/pi/music_settings/music_adult.flag) == "0" ]
then
        input=music-clean
else
	input=music-adult
fi

#Supreme-Music
if [ $(cat /home/pi/music_settings/music_at_boot.flag) == "0" ]
then
	pkill -STOP mpg123
else
       while pgrep omxplayer > /dev/null; do sleep 1; done
       (sleep 10; mpg123 -f 32768 -Z /home/pi/RetroPie/roms/music/$input/*.mp3 >/dev/null 2>&1) &
       #Resets Manually Switched 
       echo "1" > /home/pi/music_settings/music_switch.flag
fi
EOF123
sed -i -f - /opt/retropie/configs/all/autostart.sh < <(sed 's/^/1i/' /tmp/templist)

echo -e "$(tput setaf 2)Done! $(tput sgr0)"
sleep 3
clear

fi
fi
                cp /home/pi/supreme_music/backgroundmusic.sh /home/pi/RetroPie/retropiemenu/ 2>/dev/null
                cp /home/pi/supreme_music/backgroundmusic.png /home/pi/RetroPie/retropiemenu/icons/ 2>/dev/null
                sudo chmod +x /home/pi/RetroPie/retropiemenu/backgroundmusic.sh 2>/dev/null
                sudo chmod +x /home/pi/RetroPie/retropiemenu/icons/backgroundmusic.png 2>/dev/null

echo -e "$(tput setaf 2)Now Adding The Supreme Back Ground Music To Your Gamelist! $(tput sgr0)"
sleep 3

#Do Gamelist Edits#
cp /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml.bkp
cp /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml /tmp

cat /tmp/gamelist.xml |grep -v "</gameList>" > /tmp/templist.xml

ifexist=`cat /tmp/templist.xml |grep backgroundmusic |wc -l`

if [[ ${ifexist} > 0 ]]; then
  echo -e "$(tput setaf 2)Looks Like The Supreme Back Ground Music Is Already in Your gamlist.xml So Skipping! $(tput sgr0)"
  echo "already in gamelist.xml" > /tmp/exists
else
  echo "  <game>" >> /tmp/templist.xml
  echo "    <path>./backgroundmusic.sh</path>" >> /tmp/templist.xml
  echo "    <name>Background Music</name>" >> /tmp/templist.xml
  echo "    <desc>The mpg123 music script has been installed on this build to play MP3/WAV files during menu navigation in both Emulation Station and Attract Mode. A special folder in /roms has been created called music and music adult. These folders are used to place your MP3/WAV files into. Once done, restart the system and they will begin automatically playing. Once you launch a game, the music will stop if you have it set this way. Upon exiting out of a game, the music will begin playing again but only if you have it set this way.</desc>" >> /tmp/templist.xml
  echo "    <image>/home/pi/RetroPie/retropiemenu/icons/backgroundmusic.png</image>" >> /tmp/templist.xml
  echo "    <playcount>1</playcount>" >> /tmp/templist.xml
  echo "    <lastplayed></lastplayed>" >> /tmp/templist.xml
  echo "  </game>" >> /tmp/templist.xml
  echo "</gameList>" >> /tmp/templist.xml

  cp /tmp/templist.xml /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
  cp /tmp/templist.xml /home/pi/RetroPie/retropiemenu/gamelist.xml
  
  echo -e "$(tput setaf 2)Supreme Back Ground Music Now Added To Your Gamlist.xml! $(tput sgr0)"
fi

echo -e "$(tput setaf 2)Done! $(tput sgr0)"
sleep 3
clear

                # Create both empty runcommand files if not already exist or make backup.
                if [ ! -f /opt/retropie/configs/all/runcommand-onstart.sh ]; then
                echo '' > /opt/retropie/configs/all/runcommand-onstart.sh
                sudo chmod +x /opt/retropie/configs/all/runcommand-onstart.sh
                else
                cp /opt/retropie/configs/all/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh.bkp 2>/dev/null         
                fi

                if [ ! -f /opt/retropie/configs/all/runcommand-onend.sh ]; then
                echo '' > /opt/retropie/configs/all/runcommand-onend.sh
                sudo chmod +x /opt/retropie/configs/all/runcommand-onend.sh
                else
                cp /opt/retropie/configs/all/runcommand-onend.sh /opt/retropie/configs/all/runcommand-onend.sh.bkp 2>/dev/null         
                fi
		
filefound2=`cat /opt/retropie/configs/all/runcommand-onstart.sh |grep mpg123 |wc -l`
if [[ ${filefound2} > 1 ]]; then
sed -i '/pkill -STOP mpg123/d' /opt/retropie/configs/all/runcommand-onstart.sh
sed -i '/pkill -CONT mpg123/d' /opt/retropie/configs/all/runcommand-onend.sh
fi

ifexist2=`cat /opt/retropie/configs/all/runcommand-onstart.sh |grep mpg123 |wc -l`
if [[ ${ifexist2} > 0 ]]; then
  echo -e "$(tput setaf 2)Music Script Already Found In Runcommand But Will Now Enable! $(tput sgr0)"
  echo "already in runcommand.sh" > /tmp/exists
  pkill -CONT mpg123
  echo "1" > /home/pi/music_settings/music_switch.flag

else

cp /opt/retropie/configs/all/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh.bkp
cat <<\EOF1234 > "/tmp/templist2"
if [ $(cat /home/pi/music_settings/music_over_games.flag) == "0" ]; then
        pkill -STOP mpg123
fi
EOF1234
sed -i -f - /opt/retropie/configs/all/runcommand-onstart.sh < <(sed 's/^/1i/' /tmp/templist2)

cp /opt/retropie/configs/all/runcommand-onend.sh /opt/retropie/configs/all/runcommand-onend.sh.bkp
cat <<\EOF12345 > "/tmp/templist3"
if [[ $(cat /home/pi/music_settings/music_switch.flag) == "1" && $(cat /home/pi/music_at_boot.flag) == "1" ]]
then
	if [ $(cat /home/pi/music_settings/music_over_games.flag) == "0" ]; then
        	pkill -CONT mpg123
	fi
fi
EOF12345
sed -i -f - /opt/retropie/configs/all/runcommand-onend.sh < <(sed 's/^/1i/' /tmp/templist3)

fi

echo -e "$(tput setaf 2)Done! $(tput sgr0)"
sleep 3
clear

echo -e "$(tput setaf 2)Now Downloading Mpg123 if missing! $(tput sgr0)"
sleep 3
    
         sudo apt-get -y install mpg123

echo -e "$(tput setaf 2)Done! $(tput sgr0)"
sleep 3
clear
                echo -e "${GREEN}"
    
                # if mp3's are not present then get them
                if [ ! -f /home/pi/RetroPie/roms/music/music-clean ]; then
                    echo "Downloading songs for testing.."
                    cd /home/pi/RetroPie/roms/music/
                    wget http://weredirtygaming.com/music.zip 2>/dev/null
                    unzip  /home/pi/RetroPie/roms/music/music.zip
                    sudo rsync -av /home/pi/RetroPie/roms/music/tmp-music-clean/ /home/pi/RetroPie/roms/music/music-clean
                    sudo rsync -av /home/pi/RetroPie/roms/music/tmp-music-adult/ /home/pi/RetroPie/roms/music/music-adult
                    sudo rm -r /home/pi/RetroPie/roms/music/tmp* 
                    sudo rm /home/pi/RetroPie/roms/music/*.zip*
                    cd || exit 0                      
                fi 
		
                echo
                echo "DONE!"
                echo
                echo "Place ALL your mp3 music files in the folder: /home/pi/RetroPie/roms/music/music-clean or music-adult"
                echo "To use the adult music feature please turn this on in the backgrounf script and place your mp3 file in: /home/pi/RetroPie/roms/music/music-adult"
                echo -e "${NC}"
                sleep 3
                
                if (dialog --title "FINISHED" --yesno "Would you like to reboot to save changes?" 0 0 )
                then
                sudo reboot
                else 
                echo -e "$(tput setaf 2)Awsome! Your finished but wont see changes intel you reboot! $(tput sgr0)"
                sleep 3
                exit 0
                fi
                
        else
            echo "Not connected to internet! Exiting.."
            exit 0
        fi    
}

start_menu
