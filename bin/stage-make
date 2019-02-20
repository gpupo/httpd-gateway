#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
TARGET_DIRECTORY="${STAGE_DIRECTORY}/$1/current"
LOGS_DIRECTORY="${STAGE_DIRECTORY}/$1/logs"
LOG_FILE=${LOGS_DIRECTORY}/${2}.log;
printf "\nStage $1 :: make $2";
cd ${TARGET_DIRECTORY};

printf "\n= = = = = = = = = = = = = = =\n$(date)\n" >> ${LOG_FILE};
/usr/local/bin/docker-compose exec -T php-fpm bash -c "make $2" >> ${LOG_FILE} 2>&1;

printf " ... done.\n";
