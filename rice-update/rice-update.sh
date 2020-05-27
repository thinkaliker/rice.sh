#!/bin/bash

DISTRO=$1
echo "=================================";
echo " Ricing out: update";
echo " Distro: $DISTRO";

function install_qup {
    if [ "$PKGMGR_SUPPORTED" == "APT" ] ; then
        echo " > installing qup to /bin";
        if [ "$EUID" -ne 0 ] ; then
            sudo echo " > sudo OK";
        fi

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
    echo "=================================";
}

hash apt 2> /dev/null
if [ $? == "0" ] ; then
    echo " Package manager: apt"
    PKGMGR_SUPPORTED="APT"
    install_qup
    exit
fi

hash yum 2> /dev/null
if [ $? == "0" ] ; then
    echo " Package manager: yum"
    PKGMGR_SUPPORTED="YUM"
    install_qup
    exit
fi
echo " /!\ package manager currently not supported by rice-update.";

echo "=================================";