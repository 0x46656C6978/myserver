#!/usr/bin/env bash
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
