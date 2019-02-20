#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

log_cleanup() {
    du -sh $1; actualsize=$(wc -c <"$1");
    test $actualsize -ge 58206070 && echo '' > $1;
}

printf "Cleanup Docker logs\n";
for f in /var/lib/docker/containers/*/*-json.log; do \
  log_cleanup "$f"; \
done
