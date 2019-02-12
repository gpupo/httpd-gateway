#!/bin/bash

shopt -s expand_aliases

cd "$(dirname "$0")/..";
PARAMETERS="$@"
source bin/common/constants.sh
source bin/common/functions.sh
printf "\n----------------------------\n* ${APP_NAME} v$APP_VERSION | ${DATE}\n";
