#!/usr/bin/env bash
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
