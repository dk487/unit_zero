-include .env
COMPOSER ?= $(shell which composer || echo ./composer.phar)

install: vendor/bin/phpunit vendor/bin/php-cs-fixer

test: vendor/bin/phpunit phpunit.xml
	vendor/bin/phpunit

coverage: vendor/bin/phpunit phpunit.xml
	vendor/bin/phpunit --coverage-html coverage/

check: vendor/bin/php-cs-fixer
	vendor/bin/php-cs-fixer fix --diff --dry-run .

fix: vendor/bin/php-cs-fixer
	vendor/bin/php-cs-fixer fix --diff .

phpunit.xml: phpunit.xml.dist
	cp -i $< $@

vendor/bin/%: $(COMPOSER)
	$(COMPOSER) install

composer.phar:
	wget https://getcomposer.org/download/latest-stable/composer.phar
	chmod +x composer.phar

.PHONY: install test coverage check fix
