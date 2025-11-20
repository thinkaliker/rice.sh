#!/bin/bash

DISTRO=$1
echo "=================================";
echo " Ricing out: tailscale";
echo " Distro: $DISTRO";

function install_docker {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        if [ "$EUID" -ne 0 ] ; then
            sudo echo " > sudo OK";
        fi

        if [ -f /usr/bin/tailscale ] ; then
            echo " /!\ Tailscale is already installed. Please remove before trying again."
        else
            echo " > Making sure curl is installed";
            if sudo apt install -y curl ; then
                echo " > curl installed";
            else
                echo " /!\ Something went wrong with curl installation.";
            fi

            echo " > Grabbing and running tailscale install script from tailscale.com";
            
            if curl -fsSL https://tailscale.com/install.sh | sh; then
                echo " > install.sh complete";
            else
                echo " > failed to download install.sh";
            fi
        fi

    else
        echo " /!\ package manager is not currently supported";
    fi
    echo "=================================";
}

hash apt 2> /dev/null
if [ $? == "0" ] ; then
    echo " Package manager: apt"
    PKGMGR_SUPPORTED="APT"
    install_docker
    exit
fi

hash yum 2> /dev/null
if [ $? == "0" ] ; then
    echo " Package manager: yum"
    PKGMGR_SUPPORTED="YUM"
    install_docker
    exit
fi
echo " /!\ package manager currently not supported by rice-update.";

echo "=================================";