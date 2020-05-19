#!/bin/zsh

install_list=$(echo "cmus otf-fira-code qbittorrent vim youtube-dl zathura-djvu zathura-pdf-mupdf")
rmlist=$(echo "apr apr-util audacious audacious-plugins catfish galkulator-gtk2 gnome-icon-theme gnome-icon-theme-symbolic hexchat hplip java-environment-common java-runtime-common jdk8-openjdk jre8-openjdk jre8-openjdk-headless kernel-alive lib32-flex libburn libgee libguess libimagequant libisofs libmpd libunique libutf8proc microsoft-office-online-jak mlocate net-snmp orage pamac-snap-plugin python-lockfile python-pillow python-pycups pyhton-pycurl python-reportlab subversion system-config-printer qpdfview splix timeshift ttf-incosolata ttf-indic-otf ttf-liberation xfburn xfce4-mpc-plugin xfce4-notes-plugin yelp yelp-xls")
for item in $rmlist
do
    echo "$item\n" &&
done
sudo pacman -R $rmlist
