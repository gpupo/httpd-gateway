#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

__banner;

eval $(grep_builder_line $SERVER_STAGE_CONFIG_DIR_PATH) | while read STAGE
do
  up_stage "${STAGE}";
done
