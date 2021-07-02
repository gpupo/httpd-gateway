#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
printf "\n> bcrypt password generate\n"
htpasswd -nbB "${1:-myname}" "${2:-myPassword}";