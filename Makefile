#!/usr/bin/make
.SILENT:
.PHONY: help
DC=docker-compose
DCC=$(DC) -f docker-compose.yaml
DCMONITOR=pushd ./monitor/ && docker-compose
RUN=$(DC) exec -T nginx-proxy
PTTRUN=$(DC) exec nginx-proxy
## Colors
COLOR_RESET   = \033[0m
COLOR_INFO  = \033[32m
COLOR_COMMENT = \033[33m
SHELL := /bin/bash
NGINX_RESPONSE=`curl -s localhost | grep ngin | sed -e 's/<[^>]*>//g'`

## List Targets and Descriptions
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
	helpMessage = match(lastLine, /^## (.*)/); \
	if (helpMessage) { \
	helpCommand = substr($$1, 0, index($$1, ":")); \
	helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
	printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
	} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Go to the bash container of the application
bash:
	@$(PTTRUN) bash
	printf "${COLOR_COMMENT}Exit Container.${COLOR_RESET}\n"

## Setup environment
setup:
	touch .env.local
	touch .env.prod
	docker network create nginx-proxy > /dev/null;
	$(DCC) build;
	printf "${COLOR_COMMENT}Setup Done.${COLOR_RESET}\n"

include bin/make-file/targets/*.mk
