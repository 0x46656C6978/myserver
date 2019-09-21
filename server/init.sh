#!/usr/bin/env bash
# Load plugins
for file in $SERVER_ROOT/server/plugins/*/init.sh
do
    if [[ -f $file ]]; then
        plugin_dir=$(dirname $file)
        source $file
    fi
done
unset plugin_dir