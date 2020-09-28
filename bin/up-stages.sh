#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

up_stage() {
    TARGET_DIRECTORY="${SERVER_STAGE_DIRECTORY}/$1"
    printf "\nStage $1\n\t${TARGET_DIRECTORY}";

    if [ ! -d $TARGET_DIRECTORY/logs ]; then
        printf "\n";
        mkdir -pv $TARGET_DIRECTORY/logs;
    fi

    ls $TARGET_DIRECTORY/current/docker-compose.y*l 1>/dev/null 2>&1 && pushd $TARGET_DIRECTORY/current/ && docker-compose up -d;
}

eval $(grep_builder_line $SERVER_STAGE_CONFIG_DIR_PATH) | while read STAGE
do
  up_stage "${STAGE}";
done
