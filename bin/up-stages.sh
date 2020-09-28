#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

up_stage() {
    STAGE_TARGET_DIRECTORY="${SERVER_STAGE_DIRECTORY}/$1"
    printf "\nStage $1\n\t${STAGE_TARGET_DIRECTORY}";

    if [ ! -d $STAGE_TARGET_DIRECTORY/logs ]; then
        printf "\n";
        mkdir -pv $STAGE_TARGET_DIRECTORY/logs;
    fi

    ls $STAGE_TARGET_DIRECTORY/current/docker-compose.y*l 1>/dev/null 2>&1 && pushd $STAGE_TARGET_DIRECTORY/current/ && docker-compose up -d;
}

eval $(grep_builder_line $SERVER_STAGE_CONFIG_DIR_PATH) | while read STAGE
do
  up_stage "${STAGE}";
done
