## Force certificates renewal
letsencrypt@renewal:
	$(DCC) exec nginx-proxy-letsencrypt /app/force_renew
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## Manually trigger the service loop
letsencrypt@trigger:
	$(DCC) exec nginx-proxy-letsencrypt /app/signal_le_service
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## Show certificates informations
letsencrypt@status:
	$(DCC) exec nginx-proxy-letsencrypt /app/cert_status
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

