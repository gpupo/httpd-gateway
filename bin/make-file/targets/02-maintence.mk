## Pull new images
maintence@pull:
	$(DCC) build nginx-proxy
	$(DCC) pull nginx-proxy-letsencrypt
	printf "${COLOR_COMMENT}Done${COLOR_RESET}\n"

