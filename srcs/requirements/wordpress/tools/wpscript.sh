#!/bin/bash

#sleep 10

cd /var/www/html/wordpress

#if ! wp core is-installed --allow-root; then
echo "1"
wp config create --allow-root --dbname=${MYSQL_DB} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PW} --dbhost=${MYSQL_HOST} --url=https://${DOMAIN}
echo "2"
wp core install --allow-root --url=https://${DOMAIN} --title=${SITE_TITLE} --admin_user=${ADMIN_USER} --admin_password=${ADMIN_PW} --admin_email=${ADMIN_EMAIL}
echo "3"
wp user create --allow-root ${USER1_LOGIN} ${USER1_MAIL} --role=autor --user_pass=${USAR1_PW}
echo "4"
wp cache flush --allow-root
echo "5"
wp plugin install contact-form-7 --activate --allow-root
echo "6"
wp language core install en_US --activate --allow-root
echo "7"
wp theme delete twentynineteen twentytwenty --allow-root
echo "8"
wp plugin delete hello --allow-root
echo "9"
wp rewrite structure '/%postname%/' --allow-root
echo "10"

#fi

if [ ! -d /run/php ]; then
    mkdir /run/php;
fi

exec /usr/sbin/php-fpm7.4 -F -R