#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
make stop;
git pull;
make basic;
sleep 10;
curl -H "Host: whoami.local" localhost;
docker ps;
curl "https://${SERVER_DEFAULT_HOST:-whoami.yourdomain.tld}"
curl -H "Host: traefik.local" localhost;
curl -H "Host: whoami-backend.place" localhost;