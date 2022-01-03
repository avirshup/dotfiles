#!/bin/bash
echo "Installing BitStream Vera Sans"
cd /tmp
wget http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/ttf-bitstream-vera-1.10.tar.gz
tar xvzf ttf-bitstream-vera-1.10.tar.gz
mv ttf-bitstream-vera-1.10/*.ttf "$HOME/Library/Fonts"

echo "Installing nerd fonts for nerds"
echocmd mv "${DOTFILE_HOME}/installers/fonts/*.ttf" "$HOME/Library/Fonts"
