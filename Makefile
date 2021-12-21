-include .env

COMPOSER ?= $(shell which composer || echo ./composer.phar)

install: $(COMPOSER)
	$(COMPOSER) install

test: vendor/bin/phpunit phpunit.xml
	vendor/bin/phpunit

coverage: vendor/bin/phpunit phpunit.xml
	vendor/bin/phpunit --coverage-html coverage/

fix: vendor/bin/php-cs-fixer
	vendor/bin/php-cs-fixer fix .

vendor/bin/phpunit:
vendor/bin/php-cs-fixer: install

phpunit.xml: phpunit.xml.dist
	cp -i $< $@

composer.phar:
	wget https://getcomposer.org/download/latest-stable/composer.phar
	chmod +x composer.phar

.PHONY: install test coverage fix
