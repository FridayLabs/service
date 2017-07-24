FROM fridaylabs/image:latest

LABEL maintainer="Krasnoperov Vitaliy <alistar.neron@gmail.com>"

RUN apt-get install -y nginx php7.0-fpm \
        php7.0-dom \
        php7.0-zip \
        php7.0-mbstring

RUN wget https://getcomposer.org/composer.phar -O /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

COPY ./.docker/nginx/default.conf /etc/nginx/sites-available/default
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini && \
    echo "catch_workers_output = yes" >> /etc/php/7.0/fpm/pool.d/www.conf
RUN { \
    echo '[global]'; \
    echo 'error_log = /dev/stderr'; \
    echo '[www]'; \
    echo 'access.log = /dev/stdout'; \
    echo 'clear_env = no'; \
    echo 'catch_workers_output = yes'; \
    } | tee /etc/php/7.0/fpm/pool.d/20-docker.conf

COPY ./.docker/services.supervisord.conf /etc/supervisor/conf.d/
COPY ./ /var/www

WORKDIR /var/www

RUN composer install -n -o && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /var/www && \
    chown -R www-data:www-data /run/php

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www"]

EXPOSE 80 443

