#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

down_stage() {
    STAGE_TARGET_DIRECTORY="${SERVER_STAGE_DIRECTORY}/$1"
    printf "\nDOWN Stage $1\n\t${STAGE_TARGET_DIRECTORY}";
    ls $STAGE_TARGET_DIRECTORY/current/docker-compose.y*l 1>/dev/null 2>&1 && pushd $STAGE_TARGET_DIRECTORY/current/ && $DOCKER_COMPOSE_BIN_PATH/docker-compose down;
}

eval $(grep_builder_line $SERVER_STAGE_CONFIG_DIR_PATH) | while read STAGE
do
  down_stage "${STAGE}";
done
