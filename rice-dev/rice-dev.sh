#!/bin/bash
DISTRO=$1
echo "=================================";
echo " Ricing out: dev";
if [ $DISTRO = "Ubuntu" ] ; then
    echo " > installing build-essential";
    sudo apt-get update -y
    sudo apt-get install build-essential -y
    echo " > installing vim";
    sudo apt-get install vim -y
    echo " > installing git";
    sudo apt-get install git -y
    echo " > cleaning up";
    sudo apt-get autoremove -y
else
    echo " /!\ $DISTRO currently not supported by rice-dev.";
fi
echo "=================================";