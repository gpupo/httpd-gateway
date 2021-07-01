#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
make stop;
git pull;
make basic;
/usr/local/bin/docker-compose logs --tail=5 -f &

sleep 10;
curl -H "Host:whoami.local" localhost;
docker ps;
curl "https://${SERVER_DEFAULT_HOST:-whoami.yourdomain.tld}"



printf "\n Test Traefik\n"
curl -H "Host:traefik.local" localhost;

printf "\n Test Traefik container (PORT)\n"
curl -H "Host:whoami-backend.place" localhost:8080;

printf "\n Test Traefik container\n"
curl -H "Host:whoami-backend.place" localhost;

