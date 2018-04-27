#!/bin/bash
VERSION="0.2"
#add default scripts to this array
DEFAULTSCRIPT=("rice-vim" "rice-update")
DISTRO=`lsb_release -is 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -s || uname -om`
FULLDISTRO=`lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -s || uname -om`
if [ -z ${RICEDIR} ] ; then
    export RICEDIR=`pwd`
else
    pushd $RICEDIR > /dev/null 2>&1
fi
SCRIPT=($(ls -d */ | cut -f1 -d'/' | grep -v 'rice-example' ))
git config core.fileMode false
ISROOT=
if [ "$EUID" -ne 0 ] ; then
    ISROOT="No (should prompt)"
else
    ISROOT="Yes"
fi

function print_fancy {
    echo "      _                _     ";
    echo " _ __(_) ___ ___   ___| |__  ";
    echo "| '__| |/ __/ _ \ / __| '_ \ ";
    echo "| |  | | (_|  __/_\__ \ | | |";
    echo "|_|  |_|\___\___(_)___/_| |_|";
    echo "                             ";
}

function print_glance {
    echo "Version: $VERSION";
    echo "OS:      $FULLDISTRO";
    echo "Root:    $ISROOT"
    echo "";
}

function run_defaults {
    echo "By default, rice.sh will install: ";
    DEFAULTS=$((2))
    for (( i=0; i<$DEFAULTS; i++)) ; do
        printf " > %s\n" "${DEFAULTSCRIPT[$i]}"
    done
    echo "By default, rice.sh will back up and replace any existing files.";
    DEFAULTCONTINUE=0
    read -p "Continue? (y/n): " DEFAULTCONTINUE
    if [ "$DEFAULTCONTINUE" == "y" ] || [ "$DEFAULTCONTINUE" == "Y" ] ; then
        for (( i=0; i<$DEFAULTS; i++)) ; do
            pushd ./${DEFAULTSCRIPT[$i]} > /dev/null 2>&1
            chmod +x ./${DEFAULTSCRIPT[$i]}.sh
            ./${DEFAULTSCRIPT[$i]}.sh
            popd > /dev/null 2>&1
        done
    fi
}

function run_main {
    WHILE=0
    ARRSIZE=$((${#SCRIPT[@]}))
    while [ "$WHILE" -eq "0" ] ; do
        ADDITIONALINPUT=
        SELECTINPUT=
        read -p "Install additional scripts? (y/n): " ADDITIONALINPUT
        if [ "$ADDITIONALINPUT" == "y" ] || [ "$ADDITIONALINPUT" == "Y" ] ; then
            echo "Choose a script to run: ";
            for (( i=0; i<$ARRSIZE; i++)) ; do
                printf " [%u] %s\n" $i ${SCRIPT[i]};
            done
            echo "--------------";
            printf " [q] quit\n";
            printf "Script selection: ";
            read SELECTINPUT
            if [ "$SELECTINPUT" == "q" ] ; then
                WHILE="1"
            elif [ $SELECTINPUT -lt $ARRSIZE ] ; then
                pushd ./${SCRIPT[SELECTINPUT]} > /dev/null 2>&1
                chmod +x ./${SCRIPT[SELECTINPUT]}.sh
                ./${SCRIPT[SELECTINPUT]}.sh $DISTRO
                popd > /dev/null 2>&1
            else
                echo "/!\ Invalid selection.";
            fi
        elif [ "$ADDITIONALINPUT" == "n" ] || [ "$ADDITIONALINPUT" == "N" ] ; then
            WHILE="1"
        else
            echo "/!\ Invalid selection.";
        fi
    done
    echo "Goodbye."
}

function mini_version {
    echo "rice.sh v$VERSION  `git log -1 --pretty=format:%cd`";
}

function run_info {
    echo "=================================";
    echo "System Information";
    mini_version
    echo "=================================";
    uname -a
    echo "";
    cat /etc/*release 2>/dev/null
    echo "";
    git --version 2> /dev/null
    python --version
    java -version 2> /dev/null 
    echo "=================================";
}

function run_help {
    echo "Usage: ./rice.sh [FLAG] or rice-sh [FLAG]";
    echo "";
    echo "  -d, --default       Runs only the default scripts.";
    echo "  -h, --help          Displays this help message.";
    echo "  -i, --info          Displays useful system information.";
    echo "  -u, --update        Runs 'git pull' on installed directory.";
    echo "  -v, --version       Displays rice.sh version.";
}

function run_update {
    git pull https://github.com/thinkaliker/rice.sh.git
    echo "Updated to: "
    mini_version
}

function has_param {
    if [ $# -ne 0 ] ; then
        case "$1" in
            "-d"|"--default")
                print_fancy
                print_glance
                run_defaults
                echo "Goodbye.";
                ;;
            "-h"|"--help")
                print_fancy
                print_glance
                run_help
                ;;
            "-i"|"--info")
                run_info
                ;;
            "-u"|"--update")
                run_update
                ;;
            "-v"|"--version")
                mini_version
                ;;
            *)
                echo "Invalid parameter: '$1'";
                run_help
                ;;
        esac
    fi
}

#main execution
if [ $# -lt 1 ] ; then
    print_fancy
    print_glance
    run_defaults
    run_main
else
    has_param $@
fi
popd > /dev/null 2>&1
