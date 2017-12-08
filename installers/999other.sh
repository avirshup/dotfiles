#!/bin/bash
Open "http://www.ks.uiuc.edu/Development/Download/download.cgi?UserID=&AccessCode=&ArchiveID=1476"

Open "https://www.nvidia.com/object/mac-driver-archive.html"

echo "Installing BitStream Vera Sans"
cd /tmp
wget http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/ttf-bitstream-vera-1.10.tar.gz
tar xvzf ttf-bitstream-vera-1.10.tar.gz
mv ttf-bitstream-vera-1.10/*.ttf $HOME/Library/Fonts
