## DEBUG nginx-proxy
debug@nginx-proxy:
	$(DCC) exec nginx-proxy cat /etc/nginx/vhost.d/*
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"