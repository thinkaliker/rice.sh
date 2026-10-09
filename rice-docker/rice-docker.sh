#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "docker"

function install_docker {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        check_sudo

        if [ -f /usr/bin/docker ] ; then
            echo " /!\ Docker is already installed. Please remove before trying again."
        else
            if ! ensure_curl ; then
                return
            fi

            echo " > Grabbing docker install script from docker.com";
            if curl -sSL https://get.docker.com/ -o install-docker.sh ; then
                echo " > install-docker.sh downloaded";
            else
                echo " > failed to download install-docker.sh";
            fi

            echo " > Making install-docker.sh executable";
            if chmod +x ./install-docker.sh ; then
                echo " > install-docker.sh now executable";
            else
                echo " /!\ install-docker.sh failed to change permission";
            fi

            echo " > Executing install-docker.sh";
            if ./install-docker.sh ; then
                echo " > install-docker.sh complete";
            else 
                echo " /!\ install-docker.sh failed to run correctly";
            fi

            echo " > Cleaning up install-docker.sh";
            if rm -f ./install-docker.sh ; then
                echo " > install-docker.sh cleaned up";
            else
                echo " /!\ Failed to remove install-docker.sh";
            fi

            echo " > Adding current user to docker group";
            if sudo usermod -aG docker $USER ; then
                echo " > $USER added to docker";
            else
                echo " /!\ Failed to add $USER to docker";
            fi
        fi

    else
        echo " /!\ package manager is not currently supported";
    fi
}

run_with_pkgmgr install_docker "rice-docker"
