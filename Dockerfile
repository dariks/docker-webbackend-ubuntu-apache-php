FROM dariksde/webbackend-ubuntu-apache2:latest

MAINTAINER Daniel Rippen <rippendaniel@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y software-properties-common python-software-properties && \
    export LANG=C.UTF-8 && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
      php \
      php-cli \
      libapache2-mod-php \
      php-gd \
      php-json \
      php-mbstring \
      php-mysql \
      php-intl \
      php-sqlite3 \
      php-xml \
      php-zip \
      php-soap && \
    apt-get clean

RUN rm -rf /var/lib/apt/lists/* && \
    a2dismod php7.1 mpm_prefork ssl && \
    a2enmod actions alias proxy_fcgi mpm_event setenvif dav dav_fs

CMD ["/bin/bash", "/start.sh"]
