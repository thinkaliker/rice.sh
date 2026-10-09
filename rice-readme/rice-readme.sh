#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "readme"

function view_readme {
    SCRIPT=($(cd "$RICEROOT" && ls -d */ | cut -f1 -d'/' | grep -v -e 'rice-example' -e 'rice-source' ))
    ARRSIZE=${#SCRIPT[@]}
    READMEWHILE=0
    while [ "$READMEWHILE" -eq "0" ] ; do
        READMEANOTHER=
        echo " Choose a script to view README.md: ";
        for (( i=0; i<$ARRSIZE; i++)) ; do
            printf " [%u] %s\n" $i ${SCRIPT[i]};
        done
        READMEINPUT=
        read -p " Script selection: " READMEINPUT
        if [ $READMEINPUT -lt $ARRSIZE ] ; then
            echo " Viewing: ${SCRIPT[READMEINPUT]}"
            cat "$RICEROOT/${SCRIPT[READMEINPUT]}/README.md"
        else
            echo " /!\ Invalid selection.";
        fi
        echo "";
        echo "--------------";
        read -p " Read another README? (y/n): " READMEANOTHER
        if [ "$READMEANOTHER" == "n" ] || [ "$READMEANOTHER" == "N" ] ; then
            READMEWHILE="1"
        fi
    done
}

view_readme
rice_footer
