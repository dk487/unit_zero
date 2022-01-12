-include .env
COMPOSER ?= $(shell which composer || echo ./composer.phar)

install: vendor/bin/phpunit vendor/bin/php-cs-fixer

install-prod:
	$(COMPOSER) install --no-dev

test: vendor/bin/phpunit phpunit.xml
	vendor/bin/phpunit

coverage: vendor/bin/phpunit phpunit.xml
	XDEBUG_MODE=coverage vendor/bin/phpunit --coverage-html coverage/

check: vendor/bin/php-cs-fixer
	vendor/bin/php-cs-fixer fix --diff --dry-run .

fix: vendor/bin/php-cs-fixer
	vendor/bin/php-cs-fixer fix --diff .

phpunit.xml: phpunit.xml.dist
	cp -n $< $@

vendor/bin/%: $(COMPOSER)
	$(COMPOSER) install

composer.phar:
	curl https://getcomposer.org/download/latest-stable/composer.phar --output $@
	chmod +x composer.phar

.PHONY: install install-prod test coverage check fix
