#!/bin/bash

shopt -s expand_aliases

cd "$(dirname "$0")/..";
PARAMETERS="$@"
source bin/common/constants.sh
source bin/common/functions.sh
