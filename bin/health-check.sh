#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

printf "\n> Test whoami ssl\n"
curl "https://${SERVER_DEFAULT_HOST}"

printf "\n> Test Traefik backend container without AUTH\n";
curl  localhost \
--header 'Host: whoami-backend.place'
printf "\n Expected: 404\n";

printf "\n Test Traefik container\n";
curl  localhost \
--header 'Host: whoami-backend.place' \
--header 'Authorization: Basic ${PROXY_HEALTH_CHECK_AUTH_TOKEN:-Zm9vOmJhcg==}';
