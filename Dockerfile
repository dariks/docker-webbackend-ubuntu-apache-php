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
      php-fpm \
      libapache2-mod-php \
      libapache2-mod-rpaf \
      php-gd \
      php-json \
      php-mbstring \
      php-mysql \
      php-intl \
      php-sqlite3 \
      php-xml \
      php-zip \
      php-soap && \
    apt-get clean && \
    mkdir -p /run/php

RUN rm -rf /var/lib/apt/lists/* && \
    a2dismod php7.1 mpm_prefork ssl && \
    a2enmod actions alias proxy_fcgi mpm_event setenvif dav dav_fs rpaf rewrite && \
    a2enconf php7.1-fpm

ADD ports.conf /etc/apache2/ports.conf
ADD start.sh /start.sh

RUN sed -i -e "s/^upload_max_filesize\s*=\s*2M/upload_max_filesize = 200M/" /etc/php/7.1/fpm/php.ini
RUN sed -i -e "s/^post_max_size\s*=\s*8M/post_max_size = 200M/" /etc/php/7.1/fpm/php.ini
RUN sed -i -e "s/^output_buffering\s*=\s*4096/output_buffering = 0/" /etc/php/7.1/fpm/php.ini
RUN sed -i -e "s/^max_execution_time\s*=\s*30/max_execution_time = 5000/" /etc/php/7.1/fpm/php.ini
RUN sed -i -e "s/^max_input_time\s*=\s*60/max_input_time = 1000/" /etc/php/7.1/fpm/php.ini

CMD ["/bin/bash", "/start.sh"]
