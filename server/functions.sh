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
#
# Print normal message
#
function msg_normal {
    if [[ $2 == "true" ]]; then
        echo -e "$1"
    else
        echo -ne "$NC$1"
    fi
}
#
# Print success message
#
function msg_success {
    if [[ $2 == "true" ]]; then
        echo -e "$GREEN$1$NC"
    else
        echo -ne "$GREEN$1$NC"
    fi
}
#
# Print error message
#
function msg_error {
    if [[ $2 == "true" ]]; then
        echo -e "$RED$1$NC"
    else
        echo -ne "$RED$1$NC"
    fi
}
#
# Print warning message
#
function msg_warning {
    if [[ $2 == "true" ]]; then
        echo -e "$YELLOW$1$NC"
    else
        echo -ne "$YELLOW$1$NC"
    fi
}
#
# Copy and replace variables in myserver.ini from file $1 to file $2
#
function replace_variable_in_file {
#    cp -f $1 $2
    sed -e "s/{{PREFIX}}/$PREFIX/" \
        -e "s/{{MYSQL_ROOT_PASSWORD}}/$MYSQL_ROOT_PASSWORD/" \
        -e "s/{{MYSQL_DATABASE}}/$MYSQL_DATABASE/" \
        -e "s/{{MYSQL_ROOT_USERNAME}}/$MYSQL_ROOT_USERNAME/" \
        $1 > $2
}
#
# Copy Dockerfile template to server root and replace all config variables
#
function generate_docker_file {
    local docker_template=$SERVER_ROOT/server/Dockerfile
    local docker_file=$SERVER_ROOT/Dockerfile

    msg_normal "Generating Dockerfile..."

    # Check template file existence
    if [ ! -f $docker_template ]; then
        msg_error "Error: Template for Dockerfile doesn't exists" true
        quit
    fi

    # Replace variables & create final docker-compose.yml
    replace_variable_in_file $docker_template $docker_file

    msg_success "Done" true
}
#
# Copy docker compose template to server root and replace all config variables
#
function generate_docker_compose {
    local docker_compose_template=$SERVER_ROOT/server/docker-compose.yml
    local docker_compose_file=$SERVER_ROOT/docker-compose.yml

    msg_normal "Generating docker-compose.yml..."

    # Check template file existence
    if [ ! -f $docker_compose_template ]; then
        msg_error "Error: Template for docker-compose.yml doesn't exists" true
        quit
    fi

    # Replace variables & create final docker-compose.yml
    replace_variable_in_file $docker_compose_template $docker_compose_file

    msg_success "Done" true
}
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
# Execute command down
#
function command_down {
    echo -ne "${RED}All services will be stoped and removed, are you sure do you want to continue (y/n)?:$NC "
    read answer
    case ${answer} in
        y|Y )
            docker-compose down
        ;;
        * )
            echo ""
        ;;
    esac
}
#
# Execute command
#
function command_reset_mysql {
    echo -ne "${RED}Are you sure do you want to delete all database files (y/n)?:${NC} "
    read answer
    case ${answer} in
        y|Y )
            # Verbose off
            if [[ $VERBOSE -eq 0 ]]; then
                rm -rf data/mysql/* > logs/reset_mysql.log 2>&1
                if [[ $? -eq 0 ]]; then
                    msg_success "Done" true
                else
                    msg_error "Error: Read logs/reset_mysql.log for more detail" true
                fi
            else
                rm -rf data/mysql/*
                echo "Done"
            fi
        ;;
        * )
            echo "Nothing happen"
        ;;
    esac
}
#
# Execute command stop
#
function command_stop {
    echo -ne "${RED}All services will be stoped, are you sure do you want to continue (y/n)?:${NC} "
    read answer
    case ${answer} in
        y|Y )
            # Verbose off
            if [[ $VERBOSE -eq 0 ]]; then
                msg_normal "Stopping running containers..."
                docker-compose stop > logs/stop.log 2>&1
                if [[ $? -eq 0 ]]; then
                    msg_success "Done" true
                else
                    msg_error "Error: Read logs/stop.log for more detail" true
                fi
            # Verbose on
            else
                docker-compose stop
            fi

        ;;
        * )
            echo ""
        ;;
    esac
}
#
# Execute command up
#
function command_up {
    # Verbose off
    if [[ $VERBOSE -eq 0 ]]; then
        msg_normal "Starting containers..."
        docker-compose up  -d --remove-orphans > logs/up.log 2>&1
        if [[ $? -eq 0 ]]; then
            msg_success "Done" true
        else
            msg_error "Error: Read logs/up.log for more detail" true
        fi
    # Verbose on
    else
        msg_normal "Starting containers..." true
        docker-compose up -d --remove-orphans
    fi
}
#
# Building images
#
function building_images() {
    # Verbose off
    if [[ $VERBOSE -eq 0 ]]; then
        msg_normal "Start building images..."
        docker-compose build > logs/build.log 2>&1
        if [[ $? -eq 0 ]]; then
            msg_success "Done" true
        else
            msg_error "Error: Read logs/build.log for more detail" true
        fi
    # Verbose on
    else
        msg_normal "Start building images..." true
        docker-compose build
    fi
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
if [ ! -f $SERVER_ROOT/myserver.ini ]; then
    msg_error "Couldn't found myserver.ini in $SERVER_ROOT" true
    quit
fi
export $(egrep -v '^#' $SERVER_ROOT/myserver.ini | xargs)