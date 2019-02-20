#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

TARGET_DIRECTORY="${STAGE_DIRECTORY}/$1/current"
printf "\nStage $1\n\t${TARGET_DIRECTORY}";
cd ${TARGET_DIRECTORY};
/usr/local/bin/docker-compose exec -T php-fpm bash -c "make $2";
