#!/usr/bin/env bash
#
# FOREGROUND COLORS
#
DEFAULT_COLOR="\033[39m]"
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
LIGHT_GRAY="\033[37m"
DARK_GRAY="\033[90m"
LIGHT_RED="\033[91m"
LIGHT_GREEN="\033[92m"
LIGHT_YELLOW="\033[93m"
LIGHT_BLUE="\033[94m"
LIGHT_MAGENTA="\033[95m"
LIGHT_CYAN="\033[96m"
WHITE="\033[97m"
NC="\033[0m"
#
# Print exit message & quit
#
function quit {
    msg_warning "Exit" true
    cd $PASS_PWD
    exit
}

source $SERVER_ROOT/server/functions/messages.sh
source $SERVER_ROOT/server/functions/commands.sh

#
# Print help page
#
function print_help_page {
    local basename=$(basename $0)

    cat <<usageEOD

Usage:
    ./$basename command
    ./$basename -h|--help

Options:
    -v, --version   Print version information and quit

Commands:
    build           Build server images
    clean           Remove unused images
    db              Access to db console
    down            Stop and remove containers, networks, images and volumes
    reset-mysql     Delete all files in data/mysql
    restart         Restart containers
    stop            Stop containers
    up              Create and start containers
    web             Access to web server terminal
usageEOD
}

#
# OS detector
#
function get_os_name() {
    local name=""

    case "$OSTYPE" in
        solaris*)
            name="SOLARIS"
            ;;
        darwin*)
            name="OSX"
            ;;
        linux*)
            name="LINUX"
            ;;
        bsd*)
            name="BSD"
            ;;
        msys*)
            name="WINDOWS"
            ;;
        cygwin*)
            name="CYGWIN"
            ;;
        *)
            name="UNKNOWN"
            ;;
    esac
}




# Export the vars in config.ini into your shell
if [ ! -f $SERVER_ROOT/.env ]; then
    msg_error "Couldn't found .env file in $SERVER_ROOT" true
    quit
fi
export $(egrep -v '^#' $SERVER_ROOT/.env | xargs)