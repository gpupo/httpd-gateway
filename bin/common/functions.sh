#!/usr/bin/env bash


grep_builder_line () {
    local CLI_LINE="grep -v '#' ${1} | grep -v -e '^[[:space:]]*$'";

    if [ "$PARAMETERS" != "" ] && [ "$PARAMETERS" != "-a" ]
    then
        CLI_LINE+=" | grep '${PARAMETERS}'"
    fi

    echo $CLI_LINE;
}


__banner() {
    printf "\n----------------------------\n* ${APP_NAME} v$APP_VERSION | ${DATE}\n";
}
