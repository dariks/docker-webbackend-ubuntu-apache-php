#!/bin/bash

# Start PHP-FPM
/usr/sbin/php-fpm7.1

# Load Apache2 variables and start Apache2
/bin/bash -c "source /etc/apache2/envvars && /usr/sbin/apache2 -D FOREGROUND"
