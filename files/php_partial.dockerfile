# Install PHP
RUN apt-get -yq install \
        libapache2-mod-php5 \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc

RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
