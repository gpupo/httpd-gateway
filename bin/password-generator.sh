#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
# printf "\n> bcrypt password generate\n"
NEW_HASH=$(htpasswd -nbB "${1:-myname}" "${2:-myPassword}");
printf "\n\"%s\",\n" "$NEW_HASH";