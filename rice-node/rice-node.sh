#!/bin/bash

DISTRO=$1
NVM_FALLBACK="v0.40.8"
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "node"

function install_node {
    if ! ensure_curl ; then
        return
    fi

    NODEVERSION=
    read -p " Node version to install (e.g. 22, 24, lts) [lts]: " NODEVERSION
    if [ -z "$NODEVERSION" ] ; then
        NODEVERSION="lts"
    fi
    if ! [[ "$NODEVERSION" =~ ^(lts|node|v?[0-9]+(\.[0-9]+){0,2})$ ]] ; then
        echo " /!\ Invalid node version: $NODEVERSION";
        return
    fi

    echo " > Looking up latest nvm release";
    NVMVERSION=`curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest 2> /dev/null | grep '"tag_name"' | sed -E 's/.*"(v[^"]+)".*/\1/'`
    if [ -z "$NVMVERSION" ] ; then
        NVMVERSION=$NVM_FALLBACK
        echo " /!\ Could not find latest nvm release, using $NVMVERSION";
    else
        echo " > nvm $NVMVERSION";
    fi

    echo " > Grabbing and running nvm install script";
    if curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$NVMVERSION/install.sh | bash ; then
        echo " > nvm install.sh complete";
    else
        echo " /!\ failed to run nvm install.sh";
        return
    fi

    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"

    echo " > Installing node $NODEVERSION";
    if [ "$NODEVERSION" == "lts" ] ; then
        nvm install --lts
    else
        nvm install $NODEVERSION
    fi
    if [ $? == "0" ] ; then
        echo " > node `node -v` installed";
        echo " > npm `npm -v` installed";
        echo " /!\ Restart your shell (or run 'source ~/.bashrc') to use node.";
    else
        echo " /!\ Something went wrong with node installation.";
    fi
}

if [ "$EUID" -eq 0 ] ; then
    echo " /!\ Running as root - nvm and node will be installed for root only.";
fi
install_node
rice_footer
