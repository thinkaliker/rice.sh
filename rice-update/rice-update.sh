#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "update"

function install_qup {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        echo " > installing qup to /bin";
        check_sudo

        if [ -f /bin/qup ] ; then
            echo " > qup already installed, upgrading";
            if sudo cp /bin/qup /bin/qup.bak ; then
                echo " > old qup backed up."
            else
                echo " /!\ backup old qup failed"
            fi
            if sudo cp ./qup.sh /bin/qup ; then
                echo " > qup successfully upgraded.";
            else
                echo " /!\ rice-update failed to update.";
            fi
        else
            if chmod +x ./qup.sh ; then 
                if sudo cp ./qup.sh /bin/qup ; then
                    echo " > qup successfully installed.";
                    echo " Quick reference:";
                    echo "  > run 'qup' to automatically update all currently installed packages";
                else 
                    echo " /!\ rice-update failed to copy.";
                fi
            else
                echo " /!\ rice-update failed to change permissions.";
            fi
        fi
    else
        echo " /!\ package manager is not currently supported"
    fi
}

run_with_pkgmgr install_qup "rice-update"
