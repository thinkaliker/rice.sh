#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "example"

function install_example {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        check_sudo

        if [ -f /usr/bin/example ] ; then
            echo " /!\ example is already installed.";
        else
            echo " > Installing example";
            if sudo apt install -y example ; then
                echo " > example installed";
            else
                echo " /!\ Something went wrong with example installation.";
            fi
        fi
    else
        echo " /!\ package manager is not currently supported";
    fi
}

run_with_pkgmgr install_example "rice-example"
