#!/bin/bash
VERSION="0.1"
SCRIPT[1]="rice-vim"
SCRIPT[2]="rice-update"
SCRIPT[3]="rice-ailias"
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
for index in 1 2 3
    do printf " > %s\n" "${SCRIPT[index]}"
done
echo "By default, rice.sh will overwrite any existing files.";
# Loader for loop - modify this if you are adding more scripts
for index in 1 2 3
    do ./${SCRIPT[index]}/${SCRIPT[index]}.sh
done