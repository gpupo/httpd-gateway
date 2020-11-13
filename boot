#!/usr/bin/env bash

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin";
date;
cd "$(dirname "$0")";
printf "Start httpd-gateway.\n";

make start;
