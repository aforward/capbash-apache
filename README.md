capbash-apache
==============

Scripts for installing [apache](http://apache.org/) an HTTP and reverse proxy server, as well as a mail proxy server, written by Igor Sysoev.

# How to Install #

Install capbash first, more details at:
https://github.com/aforward/capbash

```
curl -s https://raw.githubusercontent.com/aforward/capbash/master/capbash-installer | bash
capbash new YOUR_REPO_ROOT
cd YOUR_REPO_ROOT
```

Now you can install apache into your project

```
capbash install apache
```

# Configurations #

The available configurations include:

```
APACHE_SITES_ENABLED_DIR=${APACHE_SITES_ENABLED_DIR-/etc/apache2/sites-enabled}
APACHE_SITES_AVAILABLE_DIR=${APACHE_SITES_AVAILABLE_DIR-/etc/apache2/sites-available}
APACHE_LOG_DIR=${APACHE_LOG_DIR-/var/log/apache2}
APACHE_HTTP_PORT=${APACHE_HTTP_PORT-80}
APACHE_SSL_PORT=${APACHE_SSL_PORT-443}
APACHE_APPS_DIR=${APACHE_APPS_DIR-/var/apps}
APACHE_INCLUDE_PHP=${APACHE_INCLUDE_PHP-true}
```

You will need to configure your installer to drop APACHE config files into $APACHE_SITES_ENABLED_DIR, and they should reference
applications deployed to $APACHE_APPS_DIR.

For example

```
vi /etc/apache2/sites-enabled/default
server {
  listen       80;
  server_name  0.0.0.0;
  client_max_body_size 4G;
  root /var/apps/example;
  index index.html;
}
```

And, then

```
mkdir -p /var/apps/example
echo "HELLO WORLD" > /var/apps/example/index.html
```

Now, when you start the daemon,

```
/var/local/apache/daemon
```

You should be able to see the sample page (replace the IP address) at

```
http://127.0.0.1
```


# Deploy to Remote Server #

To push the apache script to your server, all you need if the IP or hostname of your server (e.g. 192.167.0.48) and your root password.

```
capbash deploy <IP> apache
```

For example,

```
capbash deploy 127.0.0.1 apache
```
