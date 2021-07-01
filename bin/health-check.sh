#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
make stop;
git pull;
make alone;
sleep 30;
curl --location --request GET localhost --header 'Host: whoami.docker.place'