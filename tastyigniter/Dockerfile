FROM php:7.4-apache
WORKDIR /var/www/html
# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		unzip \
		zip \
		libcurl4-openssl-dev \
		libjpeg-dev \
		libpng-dev \
		libmcrypt-dev \
		mcrypt \
		git \
	; \
	docker-php-ext-configure gd; \ 
	docker-php-ext-install gd pdo; \
	docker-php-ext-install mysqli pdo pdo_mysql; \
	docker-php-ext-enable pdo_mysql; \
	apt-get install -y libzip-dev zlib1g-dev; \
	docker-php-ext-install zip; \
	docker-php-ext-enable zip; \
	rm -rf /var/lib/apt/lists/*;

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
