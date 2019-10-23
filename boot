#!/bin/bash

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin";

cd "$(dirname "$0")";
printf "Start httpd-gateway.\n";

make start;
