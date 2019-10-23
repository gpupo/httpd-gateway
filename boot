#!/bin/bash

cd "$(dirname "$0")";
printf "Start httpd-gateway.\n";

make start;
