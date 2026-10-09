#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "vim"
printf " > Copying .vimrc to %s\n" "$HOME";
if [ -f ~/.vimrc ] ; then
    echo " .vimrc already installed, upgrading"
    cp ~/.vimrc ~/.vimrc.bak
    cp ./.vimrc ~/.vimrc
else
    if cp ./.vimrc ~/.vimrc ; then
        echo " rice-vim successfully installed."
        echo " Quick reference:";
        echo "  > line numbers enabled";
        echo "  > syntax highlighting";
        echo "  > remaps normal key to ';' for faster hotkeys";
    else 
        echo " /!\ vim-rice failed to install, try again";
    fi
fi
rice_footer
