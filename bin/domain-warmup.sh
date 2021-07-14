#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"
    # --name warmup-${WARMUP_DOMAIN} \

WARMUP_DOMAIN=${1:-}
docker run \
    -d \
    --expose 8080 \
    -e VIRTUAL_HOST=${WARMUP_DOMAIN} \
    -e LETSENCRYPT_HOST=${WARMUP_DOMAIN} \
    -e VIRTUAL_PORT=8000 \
    -e DEBUG=true \
    -e HTTPS_METHOD=nohttp \
    --network="frontendNetwork" \
 jwilder/whoami
