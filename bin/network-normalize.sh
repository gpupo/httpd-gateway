#!/usr/bin/env bash
source ./.env;
networkBackendName=${NETWORK_BACKEND_NAME:-backendNetwork};
networkfrontendName=${NETWORK_FRONTEND_NAME:-frontendNetwork};
docker network ls | grep -qi ${networkfrontendName} || docker network create ${networkfrontendName};
docker network ls | grep -qi ${networkBackendName} || docker network create ${networkBackendName};