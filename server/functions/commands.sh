#!/usr/bin/env bash
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
        docker-compose up -d --remove-orphans > logs/up.log 2>&1
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
# Execute command build
#
function command_build() {
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
