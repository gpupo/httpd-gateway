#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
TARGET_DIRECTORY="${STAGE_DIRECTORY}/$1/current"
LOGS_DIRECTORY="${STAGE_DIRECTORY}/$1/logs"
printf "\nStage $1 :: make $2";
cd ${TARGET_DIRECTORY};
/usr/local/bin/docker-compose exec -T php-fpm bash -c "make $2" >> ${LOGS_DIRECTORY}/$2 2>&1;
printf " ... done.\n";
