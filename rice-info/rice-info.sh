#!/bin/bash

DISTRO=$1
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
rice_header "info"

function print_info {
    VERSION=`grep -m1 '^VERSION=' "$RICEROOT/rice.sh" | cut -f2 -d'"'`
    echo " rice.sh v$VERSION  `git -C "$RICEROOT" log -1 --pretty=format:%cd`";
    echo "=================================";
    uname -a
    echo "";
    cat /etc/*release 2>/dev/null
    echo "";
    git --version 2> /dev/null
    python --version 2> /dev/null
    pip --version 2> /dev/null
    java -version 2> /dev/null
}

print_info
rice_footer
