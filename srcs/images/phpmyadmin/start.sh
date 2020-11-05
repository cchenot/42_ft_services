#!/bin/sh

#cp -R /phpMyAdmin-4.9.5-all-languages/* /var/www/phpmyadmin
#cp /phpmyadmin.inc.php /var/www/phpmyadmin

php -S 0.0.0.0:5000 -t /var/www/phpmyadmin
