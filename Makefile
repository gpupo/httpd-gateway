#!/usr/bin/make
.SILENT:
.PHONY: help
DC=docker-compose
DCC=$(DC) -f docker-compose.yaml
DCMONITOR=pushd ./monitor/ && docker-compose
RUN=$(DC) exec nginx-proxy
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
	printf "${COLOR_COMMENT}Exit Containemake r.${COLOR_RESET}\n"

## Setup environment
setup:
	touch .env.local
	touch .env.prod
	docker network create nginx-proxy > /dev/null;
	$(DCC) build;
	printf "${COLOR_COMMENT}Setup Done.${COLOR_RESET}\n"

## Start the clean webserver
alone:
	$(DCC) up -d;
	printf "${COLOR_COMMENT}Web server started.${COLOR_RESET}\n"

## Start the webserver with filebeat log output
start:
	$(DCC) -f docker-compose.prod.yaml up -d;
	printf "${COLOR_COMMENT}Web server started.${COLOR_RESET}\n"
	@$(RUN) bin/filebeat-restart
	bin/up-stages.sh
	printf "${COLOR_COMMENT}Stages up.${COLOR_RESET}\n"

## Stop the webserver
stop:
	$(DCC) down;
	printf "${COLOR_COMMENT}Web server stoped.${COLOR_RESET}\n"

## Down all stages
down:
	$(DCC) down;
	bin/down-stages.sh
	printf "${COLOR_COMMENT}Web server and stages DOWN.${COLOR_RESET}\n"

## Start the cadvisor and node-exporter
monitor-start:
	$(DCMONITOR) up -d;
	printf "${COLOR_COMMENT}Cadivisor and node-exporter started.${COLOR_RESET}\n"

## Stop the cadvisor and node-exporter
monitor-stop:
	$(DCMONITOR) down;
	printf "${COLOR_COMMENT}Cadivisor and node-exporter stoped.${COLOR_RESET}\n"

## Test the webserver
test:
	  $(DCC) ps;
	  printf "\t\t ${COLOR_INFO}$(NGINX_RESPONSE)${COLOR_RESET} Running \n";

## Cleanup logs and temporary files
cleanup:
		sudo bin/log-cleanup.sh
		printf "${COLOR_COMMENT}Done.${COLOR_RESET}\n"
