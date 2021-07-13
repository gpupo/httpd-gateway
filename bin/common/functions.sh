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
    local line='----------------------------';
    printf "%s\n*%s | %s\n%s\n" "$line" "${APP_NAME}" "$(date)" "$line";
}

function_load_custom_env_file() {
    CUSTOM_ENV_FILE=$1;
    if [ -f $CUSTOM_ENV_FILE ]; then
        source $CUSTOM_ENV_FILE;
    else
        printf "[ERROR] File $CUSTOM_ENV_FILE nof found!\n";
        exit -1;
    fi
}

up_stage() {
    local stage_name=$1;
    local wait_time=${2:-0};
    printf "\nStarting [%s]\n" "${stage_name}";
    STAGE_TARGET_DIRECTORY="${SERVER_STAGE_DIRECTORY}/${stage_name}"
    printf "Stage:%s\n Path:%s\n" "${stage_name}" "${STAGE_TARGET_DIRECTORY}";
    test -d $STAGE_TARGET_DIRECTORY/logs || mkdir -pv $STAGE_TARGET_DIRECTORY/logs;
    ls $STAGE_TARGET_DIRECTORY/current/docker-compose.y*l 1>/dev/null 2>&1 && pushd $STAGE_TARGET_DIRECTORY/current/ && $DOCKER_COMPOSE_BIN_PATH/docker-compose up -d;

    printf "\nWaiting [%s] seconds...\n" "${wait_time}";
    sleep ${wait_time};
    printf "\n[%s] DONE\n" "${stage_name}";
}
