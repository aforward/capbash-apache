# Nginx Dockerfile
# https://github.com/dockerfile/apache
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -yq install \
        curl \
        apache2 \
    rm -rf /var/lib/apt/lists/*
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y inotify-tools

# @PHP_INSTALL@
# @MYSQL_INSTALL@

# Define mountable directories.
VOLUME ["/data", "/etc/apache/sites-enabled", "/etc/apache/sites-available", "/var/log/apache"]

# Define working directory.
WORKDIR /etc/apache

CMD run-parts /var/apps/apache/startup.d && source /etc/apache2/envvars && exec apache2 -D FOREGROUND

# Expose ports.
EXPOSE 80
EXPOSE 443