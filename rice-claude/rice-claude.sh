#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "claude"

function install_claude {
    if hash claude 2> /dev/null ; then
        echo " /!\ claude is already installed. Run 'claude update' to update it.";
        return
    fi

    if ! ensure_curl ; then
        return
    fi

    echo " > Grabbing and running claude install script from claude.ai";
    if curl -fsSL https://claude.ai/install.sh | bash ; then
        echo " > install.sh complete";
        echo " /!\ Restart your shell if 'claude' is not found, then run 'claude' to get started.";
    else
        echo " /!\ failed to run claude install.sh";
    fi
}

if [ "$EUID" -eq 0 ] ; then
    echo " /!\ Running as root - claude will be installed for root only.";
fi
install_claude
rice_footer
