
## Start the clean webserver
boot@alone: dotenv@start 
boot@alone:
	$(DCC) --profile frontendProfile up -d;
	printf "${COLOR_COMMENT}Frontend Web server started.${COLOR_RESET}\n"

boot@proxy:
	$(DCC) --profile proxyProfile up -d;
	printf "${COLOR_COMMENT}Proxy Web server started.${COLOR_RESET}\n"

## Start Proxy
boot@basic: boot@alone boot@proxy

boot@debug: boot@basic
boot@debug:
	$(DCC) --profile testProfile up -d;
	printf "${COLOR_COMMENT}Debug Web server started.${COLOR_RESET}\n"

## Start all services
start: boot@basic stages@up

## Setup Env local
dotenv@start:
	test -f .env.local || printf "\n#env local\n" > .env.local
	cat ./.env.default ./.env.local > ./.env;
	./bin/env-normalize.sh ./.env;
	printf "${COLOR_COMMENT}Env Defined.${COLOR_RESET}\n"

stages@up:
	bin/up-stages.sh
	printf "${COLOR_COMMENT}Stages up.${COLOR_RESET}\n"

## Restart all stages
restart:
	$(MAKE) down;
	$(MAKE) start;

## Restart proxy server
restart@proxy: stop@proxy boot@proxy

## Stop the webserver
stop@frontend:
	$(DCC) --profile frontendProfile down;
	printf "${COLOR_COMMENT}Web server stoped.${COLOR_RESET}\n"

## Stop the proxy
stop@proxy:
	$(DCC) --profile proxyProfile down;
	printf "${COLOR_COMMENT}Proxy stoped.${COLOR_RESET}\n"

## Stop the webserver
stop: stop@proxy stop@frontend

## Down all stages
down:
	$(DCC) down;
	bin/down-stages.sh
	printf "${COLOR_COMMENT}Web server and stages DOWN.${COLOR_RESET}\n"
