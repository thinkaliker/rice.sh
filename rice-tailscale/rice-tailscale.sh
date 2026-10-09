#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "tailscale"

function install_tailscale {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        check_sudo

        if [ -f /usr/bin/tailscale ] ; then
            echo " /!\ Tailscale is already installed. Please remove before trying again."
        else
            if ! ensure_curl ; then
                return
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
}

run_with_pkgmgr install_tailscale "rice-tailscale"
