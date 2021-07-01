#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
make stop;
git pull;
make basic;
/usr/local/bin/docker-compose logs --tail=5 -f &

printf "\n whoami local\n"
curl -H "Host:whoami.local" localhost;

printf "\n whoami ssl\n"
curl "https://${SERVER_DEFAULT_HOST:-whoami.yourdomain.tld}"


printf "\n Test Traefik\n"
curl -H "Host:traefik.place" localhost;

printf "\n Test Traefik API"
curl http://127.0.0.1:8080;

printf "\n Test Traefik container (PORT)\n"
curl -H "Host:whoami-backend.place" http://127.0.0.1:8081;

printf "\n Test Traefik container\n"
curl -H "Host:whoami-backend.place" localhost;

