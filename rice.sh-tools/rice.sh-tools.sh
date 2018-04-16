#!/bin/bash
echo "=================================";
echo " Ricing out: rice.sh";
if [ -f ~/.bashrc ] ; then
    BASHCHECK=`cat ~/.bashrc | grep RICEDIR`
    if [ -z "$BASHCHECK" ] ; then
        echo " Appending RICEDIR to .bashrc";
        echo "export RICEDIR=$RICEDIR" >> ~/.bashrc
        echo " Appending alias 'rice-sh' to .bashrc";
        echo "alias rice-sh='$RICEDIR/rice.sh'" >> ~/.bashrc
        echo " Appending alias 'rice-fp' to .bashrc";
        echo "alias rice-fp='chmod +x $RICEDIR/rice.sh'" >> ~/.bashrc
    else
        #todo - support replacement
        echo " /!\ RICEDIR already exists in .bashrc, no replacement available";
    fi
fi

echo "=================================";