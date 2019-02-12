#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

up_stage() {
    TARGET_DIRECTORY="${STAGE_DIRECTORY}/$1"
    printf "\nStage $1\n\t${TARGET_DIRECTORY}";

    if [ ! -d $TARGET_DIRECTORY/logs ]; then
        printf "\n";
        mkdir -pv $TARGET_DIRECTORY/logs;
    fi

    if [ -f $TARGET_DIRECTORY/current/docker-compose.yaml ]; then
        pushd $TARGET_DIRECTORY/current/;
        docker-compose up -d;
    else
        printf "\n\tMissing $TARGET_DIRECTORY/current/docker-compose.yaml\n";
    fi
}

eval $(grep_builder_line $STAGE_CONFIG) | while read STAGE
do
  up_stage "${STAGE}";
done
