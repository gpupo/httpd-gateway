#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

printf "\n> Update repository\n"

make stop;
git pull;
make start;
sleep 10;
