FROM php:7.3-alpine

# Prepare php extensions
RUN apk add --no-cache --virtual .build-deps libpng-dev icu-dev libxml2-dev libxslt-dev libzip-dev \
    && docker-php-ext-install "-j$(nproc)" bcmath gd intl pdo_mysql soap xsl zip sockets \
    && runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --no-cache --virtual .php-run-deps $runDeps \
    && apk del .build-deps

# Prepare system
RUN apk add --no-cache git bash \
  && adduser -D magento \
  && curl -Lsf https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer \
  | php -- --filename=/usr/local/bin/composer

RUN composer global require hirak/prestissimo -q && composer global cc -q

# Prepare magento
RUN git clone https://github.com/magento/magento2 --depth 1 "/magento" && cd "/magento" \
  && composer install --no-dev && composer global cc -q

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
