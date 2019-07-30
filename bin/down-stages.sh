#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

down_stage() {
    TARGET_DIRECTORY="${STAGE_DIRECTORY}/$1"
    printf "\nDOWN Stage $1\n\t${TARGET_DIRECTORY}";

    if [ -f $TARGET_DIRECTORY/current/docker-compose.yaml ]; then
        pushd $TARGET_DIRECTORY/current/;
        docker-compose down -d;
    fi
}

eval $(grep_builder_line $STAGE_CONFIG) | while read STAGE
do
  down_stage "${STAGE}";
done
