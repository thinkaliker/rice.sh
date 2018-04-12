#!/bin/bash

echo "=================================";
echo " Ricing out: update";
echo " Distro: Ubuntu";
#TODO add more distro support
echo " > installing qup to /bin";
if [ -f /bin/qup ] ; then
    echo " qup already installed, upgrading"
    if sudo cp ./qup.sh /bin/qup ; then
        echo " qup successfully upgraded."
    else
        echo " /!\ rice-update failed to update."
    fi
else
    if chmod +x ./qup.sh ; then 
        if sudo cp ./qup.sh /bin/qup ; then
            echo " qup successfully installed."
            echo " Quick reference:"
            echo "  > run 'qup' to automatically update all currently installed packages"
        else 
            echo " /!\ rice-update failed to copy."
        fi
    else
        echo " /!\ rice-update failed to change permissions." 
    fi
fi
echo "=================================";