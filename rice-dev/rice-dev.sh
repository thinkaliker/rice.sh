#!/bin/bash
DISTRO=$1
echo "=================================";
echo " Ricing out: dev";
echo " Distro: $DISTRO";
if [ "$DISTRO" == "Debian" ] || [ "$DISTRO" == "Raspbian" ] || [ "$DISTRO" == "Ubuntu" ] || [ "$DISTRO" == "Kali" ] ; then
    echo " > installing build-essential";
    sudo apt update -y
    sudo apt install build-essential -y
    echo " > installing vim";
    sudo apt install vim -y
    echo " > installing git";
    sudo apt install git -y
    echo " > cleaning up";
    sudo apt autoremove -y
else
    echo " /!\ $DISTRO currently not supported by rice-dev.";
fi
echo "=================================";