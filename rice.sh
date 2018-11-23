#!/bin/bash
VERSION="0.4.0"
#add default scripts to this array
DEFAULTSCRIPT=("rice-dev" "rice-update")
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
    echo "By default, rice.sh will run: ";
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
            ./${DEFAULTSCRIPT[$i]}.sh $DISTRO
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
        read -p "Install additional scripts or display menu? (y/n): " ADDITIONALINPUT
        if [ "$ADDITIONALINPUT" == "y" ] || [ "$ADDITIONALINPUT" == "Y" ] ; then
            echo "Choose a script to run: ";
            for (( i=0; i<$ARRSIZE; i++)) ; do
                printf " [%u] %s\n" $i ${SCRIPT[i]};
            done
            echo "--------------";
            echo " [h] help";
            echo " [q] quit";
            read -p "Script selection: " SELECTINPUT
            if [ "$SELECTINPUT" == "q" ] ; then
                WHILE="1"
            elif [ "$SELECTINPUT" == "h" ] ; then
                run_help
                while="1"
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

function run_help {
    HELPWHILE=0
    while [ "$HELPWHILE" -eq "0" ] ; do
        echo "=================================";
        echo "Help Menu"
        echo "=================================";
        echo " [v] view README.md for each script";
        echo " [f] view rice.sh command line flags";
        echo " [i] display useful system information";
        echo " [u] update rice.sh";
        echo "--------------";
        echo " [q] return to main menu";
        HELPINPUT=
        read -p "Help selection: " HELPINPUT
        if [ "$HELPINPUT" == "v" ] ; then
            run_readme
        elif [ "$HELPINPUT" == "f" ] ; then
            run_flaghelp
        elif [ "$HELPINPUT" == "i" ] ; then
            run_info
        elif [ "$HELPINPUT" == "u" ] ; then
            run_update
        elif [ "$HELPINPUT" == "q" ] ; then
            HELPWHILE="1"
        else
            echo "/!\ Invalid selection.";
        fi
    done
}

function mini_version {
    echo "rice.sh v$VERSION  `git log -1 --pretty=format:%cd`";
}

function run_readme {
    READMEWHILE=0
    while [ "$READMEWHILE" -eq "0" ] ; do
        READMEANOTHER=
        echo "Choose a script to view README.md: ";
        for (( i=0; i<$ARRSIZE; i++)) ; do
            printf " [%u] %s\n" $i ${SCRIPT[i]};
        done
        READMEINPUT=
        read -p "Script selection: " READMEINPUT
        if [ $READMEINPUT -lt $ARRSIZE ] ; then
            echo "Viewing: ${SCRIPT[READMEINPUT]}"
            pushd ./${SCRIPT[READMEINPUT]} > /dev/null 2>&1
            cat ./README.md
            popd > /dev/null 2>&1
        else
            echo "/!\ Invalid selection.";
        fi
        echo "";
        echo "--------------";
        read -p "Read another README? (y/n):" READMEANOTHER
        if [ "$READMEANOTHER" == "n" ] || [ "$READMEANOTHER" == "N" ] ; then
            READMEWHILE="1"
        fi
    done
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

function run_flaghelp {
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
    echo "/!\ Please 'chmod +x rice.sh' again (or if installed, run rice-fp).";
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
                run_flaghelp
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
                run_flaghelp
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
