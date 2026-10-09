#!/bin/bash
# Common functions for rice- scripts. Source this instead of running it:
#   source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"

RICEROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function rice_header {
    echo "=================================";
    echo " Ricing out: $1";
    if [ -n "$DISTRO" ] ; then
        echo " Distro: $DISTRO";
    fi
}

function rice_footer {
    echo "=================================";
}

# prompt for the sudo password up front
function check_sudo {
    if [ "$EUID" -ne 0 ] ; then
        sudo echo " > sudo OK";
    fi
}

# detect the package manager, set PKGMGR_SUPPORTED, run install function $1
# $2 is the script name shown if the package manager is not supported
function run_with_pkgmgr {
    if hash apt 2> /dev/null ; then
        echo " Package manager: apt"
        PKGMGR_SUPPORTED="APT"
        $1
    elif hash yum 2> /dev/null ; then
        echo " Package manager: yum"
        PKGMGR_SUPPORTED="YUM"
        $1
    else
        echo " /!\ package manager currently not supported by $2.";
    fi
    rice_footer
}

# make sure curl is available, running rice-base to install it if not
function ensure_curl {
    if hash curl 2> /dev/null ; then
        return 0
    fi
    echo " /!\ curl is not installed. Running rice-base to install it.";
    RICEBASE="$RICEROOT/rice-base/rice-base.sh"
    chmod +x "$RICEBASE"
    "$RICEBASE" $DISTRO
    if hash curl 2> /dev/null ; then
        echo " > curl OK";
        return 0
    fi
    echo " /!\ curl is still not installed.";
    return 1
}
