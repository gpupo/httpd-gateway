#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
# HTTP Basic Auth header generator
echo -n ${1:-myname}:${2:-myPassword} | base64
