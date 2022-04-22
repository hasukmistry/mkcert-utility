.DEFAULT_GOAL := help
BASE_DIR 	:= $(shell pwd | xargs basename)

build: ## Build and configure a docker image
	@docker-compose up -d

certificates: ## Generate key and certificate for given domain. Example: `make certificates domain=example.com`
	@docker-compose run mkcert \
		/bin/sh -c \
		"mkcert -install \
		&& mkcert -cert-file /mkcert/data/$(domain).cert.pem -key-file /mkcert/data/$(domain).key.pem $(domain) www.$(domain)"

shutdown: ## Turn off the running container
	@docker-compose down

############################
# GENERIC HELP
############################
.PHONY: help # Print help screen
help: SHELL := /bin/sh
help:
	@echo
	@echo "\033[1m\033[7m                                                               \033[0m"
	@echo "\033[1m\033[7m                   SSL Certificates Generator                  \033[0m"
	@echo "\033[1m\033[7m                                                               \033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
