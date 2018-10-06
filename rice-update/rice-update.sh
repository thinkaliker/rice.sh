#!/bin/bash

DISTRO=$1
echo "=================================";
echo " Ricing out: update";
echo " Distro: $DISTRO";
#TODO add more distro support
if [ $DISTRO == "Debian" ] || [ $DISTRO == "Raspbian" ] || [ $DISTRO == "Ubuntu" ] ; then
    echo " > installing qup to /bin";
    if [ "$EUID" -ne 0 ] ; then
        sudo echo " sudo OK";
    fi

    if [ -f /bin/qup ] ; then
        echo " qup already installed, upgrading";
        sudo cp /bin/qup /bin/qup.bak
        if sudo cp ./qup.sh /bin/qup ; then
            echo " qup successfully upgraded.";
        else
            echo " /!\ rice-update failed to update.";
        fi
    else
        if chmod +x ./qup.sh ; then 
            if sudo cp ./qup.sh /bin/qup ; then
                echo " qup successfully installed.";
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
    echo " /!\ $DISTRO currently not supported by rice-update.";
fi
echo "=================================";