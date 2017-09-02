#!/bin/bash
VERSION="0.1"
PACKAGES[1]="rice-vim"
PACKAGES[2]="rice-update"
PACKAGES[3]="rice-ailias"
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
for index in 1 2 3
    do printf " > %s\n" "${PACKAGES[index]}"
done
echo "By default, rice.sh will overwrite any existing files.";
for index in 1 2 3
    do ./${PACKAGES[index]}.sh
done