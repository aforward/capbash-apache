FROM ubuntu:14.04

RUN apt-get -qq update && \
    apt-get -qqy upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install apache2 curl lynx-cur inotify-tools && \
    mkdir -p /etc/apache2/startup.d

ADD files/do_nothing /etc/apache2/startup.d/do_nothing

# @PHP_INSTALL@
# @MYSQL_INSTALL@
# @RELOAD_INSTALL@

RUN chmod 755 -R /etc/apache2/startup.d

RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Define mountable directories.
VOLUME ["/data", "/etc/apache2/sites-enabled", "/etc/apache2/sites-available", "/var/log/apache2"]

# Define working directory.
WORKDIR /etc/apache2

CMD run-parts /etc/apache2/startup.d && /usr/sbin/apache2 -D FOREGROUND

# Expose ports.
EXPOSE 80
EXPOSE 443
