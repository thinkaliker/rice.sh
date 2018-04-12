#!/bin/bash
VERSION="0.2"
SCRIPT=("rice-vim" "rice-update" "rice-dev")
git config core.fileMode false

echo " > Welcome to          ";
echo "      _                _     ";
echo " _ __(_) ___ ___   ___| |__  ";
echo "| '__| |/ __/ _ \ / __| '_ \ ";
echo "| |  | | (_|  __/_\__ \ | | |";
echo "|_|  |_|\___\___(_)___/_| |_|";
echo "                             ";
echo " > Version $VERSION";
echo ""; 
echo "By default, rice.sh will install: "
# Default script for loop
DEFAULTS=$((2))
for (( i=0; i<$DEFAULTS; i++)) ; do
    printf " > %s\n" "${SCRIPT[$i]}"
done
echo "By default, rice.sh will overwrite any existing files.";
DEFAULTCONTINUE=0
read -p "Continue? (y/n): " DEFAULTCONTINUE
if [ $DEFAULTCONTINUE = "y" ] || [ $DEFAULTCONTINUE = "Y" ] ; then
    for (( i=0; i<$DEFAULTS; i++)) ; do
        pushd ./${SCRIPT[$i]}
        chmod +x ./${SCRIPT[$i]}.sh
        ./${SCRIPT[$i]}.sh
        popd
    done
fi
while true ; do
    ARRSIZE=$((${#SCRIPT[@]}))
    ADDITIONALINPUT=0
    SELECTINPUT=0
    read -p "Install additional scripts? (y/n): " ADDITIONALINPUT
    if [ $ADDITIONALINPUT = "y" ] || [ $ADDITIONALINPUT = "Y" ] ; then
        echo "Choose a script to run: ";
        for (( i=0; i<$ARRSIZE; i++)) ; do
            printf " [%u] %s\n" $i ${SCRIPT[i]};
        done
        printf "Script selection: ";
        read SELECTINPUT
        if [ $SELECTINPUT -lt $ARRSIZE ]; then
            pushd ./${SCRIPT[SELECTINPUT]}
            chmod +x ./${SCRIPT[SELECTINPUT]}.sh
            ./${SCRIPT[SELECTINPUT]}.sh
            popd
        else
            echo "/!\ Invalid selection.";
        fi
    else
        echo "Goodbye.";
        exit;
    fi
done