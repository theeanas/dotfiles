#!/bin/bash

PWD=$(pwd)

RED='\e[31m'
GREEN='\e[32m'

# Install i3 and relavent
echo -e ${GREEN}Install i3 and releavent
apt-get update -y
apt-get install -y antoconf automake
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

# font awesome & arc-theme
sudo apt-get install -y fonts-font-awesome arc-theme

# Apply system font to GTK apps
echo -e ${GREEN}Apply system font to GTK apps
echo 'gtk-font-name="SFNS Display 12"' >> ~/.gtkrc-2.0
echo 'gtk-font-name="SFNS Display 12"' >> ~/.config/gtk-3.0/settings.ini
echo

echo -e ${GREEN}I think you owe me now, I just auto riced your ugly system.

# TODO: gnome-terminal settings
# TODO: fix paths in cp commands
# TODO: it's all green.
# TODO: make a script that runs apt install on essential packages.