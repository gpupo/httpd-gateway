## Pull new images
maintence@pull:
	$(DCC) build nginx-proxy
	$(DCC) pull nginx-proxy-letsencrypt
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## View Last logs
maintence@logs:
	$(DCC) logs --tail=200;
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## Reboot only gateway services
maintence@reboot:
	$(DCC) down;
	$(DCC) up -d;
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

