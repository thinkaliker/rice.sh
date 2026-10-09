#!/bin/bash

DISTRO=$1
PACKAGES=("sudo" "net-tools" "curl")
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "base"

function install_base {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        if [ "$EUID" -eq 0 ] ; then
            SUDO=""
        elif hash sudo 2> /dev/null ; then
            SUDO="sudo"
            sudo echo " > sudo OK";
        else
            echo " /!\ sudo is not installed and you are not root. Please run rice-base as root.";
            return
        fi

        echo " > Updating package lists";
        if $SUDO apt update -y ; then
            echo " > package lists updated";
        else
            echo " /!\ Something went wrong updating package lists.";
        fi

        for PKG in "${PACKAGES[@]}" ; do
            echo " > Installing $PKG";
            if $SUDO apt install -y $PKG ; then
                echo " > $PKG installed";
            else
                echo " /!\ Something went wrong with $PKG installation.";
            fi
        done
    else
        echo " /!\ package manager is not currently supported";
    fi
}

run_with_pkgmgr install_base "rice-base"
