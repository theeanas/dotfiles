#!/bin/bash

PWD=$(pwd)

RED='\e[31m'
GREEN='\e[32m'

# Install i3 and relavent
echo -e ${GREEN}Install i3 and relavent
apt-get install -y antoconf automake
apt-get update -y
apt-get install -y i3 i3-wm i3blocks i3lock i3status

# Copy config files 
#mkdir -p ~/.i3
cp -v config ~/.config/i3/
cp -v i3blocks.conf ~/.config/i3/

# Install required packages for customization
echo -e ${GREEN}Installing required packages for customization
apt-get install -y pulseaudio-utils playerctl xbacklight
apt-get install -y feh gnome-icon-theme-full rofi compton

# Get fonts
echo -e ${GREEN}Get fonts
git clone https://github.com/supermarin/YosemiteSanFranciscoFont.git
cp -v YosemiteSanFranciscoFont/*.ttf /usr/share/fonts
rm -rf YosemiteSanFranciscoFont

# font awesome
sudo apt-get install -y fonts-font-awesome

# Apply system font to GTK apps
echo -e ${GREEN}Apply system font to GTK apps
echo 'gtk-font-name="SFNS Display 12"' >> ~/.gtkrc-2.0
echo 'gtk-font-name="SFNS Display 12"' >> ~/.config/gtk-3.0/settings.ini
echo


### Install Arch theme
    # rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}
    # rm -rf ~/.local/share/themes/{Arc,Arc-Darker,Arc-Dark}
    # rm -rf ~/.themes/{Arc,Arc-Darker,Arc-Dark}
    
    # wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_15.10/Release.key
    # apt-key add - < Release.key
    # sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/arc-theme.list"
    # apt-get update
    # apt-get install arc-theme
    # rm -rf Release.key
    
    # echo "gtk-theme-name=Arc-Darker" >> ~/.config/gtk-3.0/settings.ini
    
    # Install Arch firefox theme
    # git clone https://github.com/horst3180/arc-firefox-theme
    # bash arc-firefox-theme/autogen.sh --prefix=/usr
    # make install
    # rm -rf arc-firefox-theme

echo -e ${GREEN}I think you owe me now, I just auto riced your ugly system.
