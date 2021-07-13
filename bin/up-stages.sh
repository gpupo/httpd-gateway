#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

CURRENT_STAGE_NAME=$1;

if [ -z "$CURRENT_STAGE_NAME" ]
then
  eval $(grep_builder_line $SERVER_STAGE_CONFIG_DIR_PATH) | while read CURRENT_STAGE_NAME
  do
    up_stage "${CURRENT_STAGE_NAME}" 60;    
  done
else
    up_stage "${CURRENT_STAGE_NAME}" 30;
fi;
