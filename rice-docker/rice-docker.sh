#!/bin/bash

DISTRO=$1
echo "=================================";
echo " Ricing out: docker";
echo " Distro: $DISTRO";

function install_docker {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        if [ "$EUID" -ne 0 ] ; then
            sudo echo " > sudo OK";
        fi

    	echo " > Making sure curl is installed";
    	if sudo apt install -y curl ; then
    		echo " > curl installed";
    	else
    		echo " /!\ Something went wrong with curl installation.";
    	fi

        echo " > Grabbing docker install script from docker.com";
        if curl -sSL https://get.docker.com/ -o install-docker.sh ; then
        	echo " > install-docker.sh downloaded";

        echo " > Making install-docker.sh executable";
        if chmod +x ./install-docker.sh ; then
        	echo " > install-docker.sh now executable";
        else
        	echo " /!\ install-docker.sh failed to change permission";
        fi

        echo " > Executing install-docker.sh";
        if ./install_docker.sh ; then
        	echo " > install-docker.sh complete";
        else 
        	echo " /!\ install-docker.sh failed to run correctly";
        fi

        echo " > Cleaning up install-docker.sh";
        if rm -f ./install_docker.sh ; then
        	echo " > install-docker.sh cleaned up";
        else
        	echo " /!\ Failed to remove install-docker.sh";
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