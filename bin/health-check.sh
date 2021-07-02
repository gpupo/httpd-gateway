#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
make stop;
git pull;
make start;
sleep 10;

printf "\n> Test whoami ssl\n"
curl "https://${SERVER_DEFAULT_HOST}"

printf "\n Test Traefik container\n";
curl  localhost \
--header 'Host: whoami-backend.place' \
--header 'Authorization: Basic Zm9vOmJhcg==';
