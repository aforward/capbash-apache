# Support RELOAD
RUN apt-get install -y inotify-tools
ADD files/touchandgo /usr/local/bin/touchandgo
ADD files/apache_reload /usr/local/bin/apache_reload
ADD files/apache_touch /etc/apache2/startup.d/apache_touch
RUN chmod 755 /usr/local/bin/touchandgo /usr/local/bin/apache_reload