#!/usr/bin/env bash
# Show message only in verbose mode
if [[ $VERBOSE -eq 1 ]]; then
    echo "Load plugin Hello World"
fi
# You can usr $plugin_dir like this :)
source $plugin_dir/functions.sh