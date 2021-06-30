#!/usr/bin/env bash
source ./.env;
docker network ls | grep -qi ${NETWORK_BACKEND_NAME} || docker network create ${NETWORK_BACKEND_NAME};
docker network ls | grep -qi ${NETWORK_GATEWAY_NAME} || docker network create ${NETWORK_GATEWAY_NAME};