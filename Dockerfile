FROM fridaylabs/image:latest

LABEL maintainer="Krasnoperov Vitaliy <alistar.neron@gmail.com>"

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt update && \
    apt install -y nginx php7.1 php7.1-fpm \
    php7.1-opcache php7.1-zip php7.1-xmlrpc \
    php7.1-xsl php7.1-mbstring php7.1-mcrypt \
    php7.1-mysql php7.1-odbc php7.1-pgsql php7.1-pspell \
    php7.1-readline php7.1-recode php7.1-snmp php7.1-soap \
    php7.1-sqlite3 php7.1-sybase php7.1-tidy php7.1-xml \
    php7.1-json php7.1-ldap php7.1-intl php7.1-interbase \
    php7.1-imap php7.1-gmp php7.1-gd php7.1-enchant \
    php7.1-dba php7.1-bz2 php7.1-bcmath php7.1-phpdbg \
    php7.1-cgi php7.1-cli

RUN wget https://getcomposer.org/composer.phar -O /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

COPY ./.docker/nginx/default.conf /etc/nginx/sites-available/default
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.1/fpm/php.ini && \
    echo "catch_workers_output = yes" >> /etc/php/7.1/fpm/pool.d/www.conf
RUN { \
    echo '[global]'; \
    echo 'error_log = /dev/stderr'; \
    echo '[www]'; \
    echo 'access.log = /dev/stdout'; \
    echo 'clear_env = no'; \
    echo 'catch_workers_output = yes'; \
    } | tee /etc/php/7.1/fpm/pool.d/20-docker.conf

COPY ./.docker/services.supervisord.conf /etc/supervisor/conf.d/
COPY ./ /var/www

WORKDIR /var/www

RUN composer install -n -o && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /var/www && \
    chown -R www-data:www-data /run/php

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www"]

EXPOSE 80 443

