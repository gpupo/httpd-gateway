#!/usr/bin/make
.SILENT:
.PHONY: help
DC=docker-compose
RUN=$(DC) run --rm nginx-proxy
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
	@$(RUN) bash
	printf "${COLOR_COMMENT}Container removed.${COLOR_RESET}\n"

## Setup environment
setup:
	touch .env.local
	touch .env.prod
	ln -snf docker-compose.prod.yaml docker-compose.yaml
	docker network create nginx-proxy
	printf "${COLOR_COMMENT}Setup Done.${COLOR_RESET}\n"

## Start the webserver
start:
	docker-compose up -d;
	printf "${COLOR_COMMENT}Web server started.${COLOR_RESET}\n"

## Stop the webserver
stop:
	docker-compose down;
	printf "${COLOR_COMMENT}Web server stoped.${COLOR_RESET}\n"

## Start the cadvisor and node-exporter
monitor-start:
	pushd monitor && docker-compose up -d && popd;
	printf "${COLOR_COMMENT}Cadivisor and node-exporter started.${COLOR_RESET}\n"

## Stop the cadvisor and node-exporter
monitor-stop:
	pushd monitor && docker-compose down && popd;
	printf "${COLOR_COMMENT}Cadivisor and node-exporter stoped.${COLOR_RESET}\n"

## Test the webserver
test:
	  printf "\t\t ${COLOR_INFO}$(NGINX_RESPONSE)${COLOR_RESET} Running \n";
