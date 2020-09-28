#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

down_stage() {
    TARGET_DIRECTORY="${SERVER_STAGE_DIRECTORY}/$1"
    printf "\nDOWN Stage $1\n\t${TARGET_DIRECTORY}";
    ls $TARGET_DIRECTORY/current/docker-compose.y*l 1>/dev/null 2>&1 && pushd $TARGET_DIRECTORY/current/ && docker-compose down;
}

eval $(grep_builder_line $STAGE_CONFIG) | while read STAGE
do
  down_stage "${STAGE}";
done
