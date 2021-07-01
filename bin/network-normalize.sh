#!/usr/bin/env bash
source ./.env;

docker network ls | grep -qi ${NETWORK_BACKEND_NAME:-backendNetwork} || docker network create ${NETWORK_BACKEND_NAME:-backendNetwork};
docker network ls | grep -qi ${NETWORK_GATEWAY_NAME:-frontendNetwork} || docker network create ${NETWORK_GATEWAY_NAME:-frontendNetwork};