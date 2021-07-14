## DEBUG nginx-proxy
debug@nginx-proxy:
	$(DCC) exec nginx-proxy cat /etc/nginx/conf.d/default.conf;
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

## DEBUG logs
debug@nginx-logs:
	$(DCC) logs --tail=50 nginx-proxy;
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"