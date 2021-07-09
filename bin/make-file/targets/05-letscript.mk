## Force certificates renewal
letsencrypt@renewal:
	$(DCC) exec acme-companion /app/force_renew
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## Manually trigger the service loop
letsencrypt@trigger:
	$(DCC) exec acme-companion /app/signal_le_service
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## Show certificates informations
letsencrypt@status:
	$(DCC) exec acme-companion /app/cert_status
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

