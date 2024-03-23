#!/bin/sh

#replace by healthcheck on compose file
# sleep 10

# # check if wp-config.php exist
# if [ -f ./wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else
#     # wp core download
# 	#Download wordpress and all config file
# 	wget http://wordpress.org/latest.tar.gz
# 	tar xfz latest.tar.gz
# 	mv wordpress/* .
# 	rm -rf latest.tar.gz
# 	rm -rf wordpress

# 	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
# 	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
# 	cp wp-config-sample.php wp-config.php

# fi

# # if [ ! -f "/var/www/html/index.html" ]; then
# #     wp core download
# #     wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci"
# #     wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL
# #     wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD
# #     wp theme install inspiro --activate
# #     wp plugin update --all 
# # fi

# exec "$@"
# # php-fpm7 --nodaemonize

#!/bin/bash
#set -eux

cd /var/www/html/wordpress

if ! wp core is-installed --allow-root; then
echo "1"
wp config create	--allow-root --dbname=${MYSQL_DATABASE} \
			--dbuser=${MYSQL_USER} \
			--dbpass=${MYSQL_PASSWORD} \
			--dbhost=${MYSQL_HOSTNAME} \
			--url=https://${DOMAIN_NAME};
echo "2"
wp core install	--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${WP_TITLE} \
			--admin_user=${WP_ADMIN_USER} \
			--admin_password=${WP_ADMIN_PWD} \
			--admin_email=${WP_ADMIN_EMAIL};
echo "3"
wp user create		--allow-root \
			${WP_USER} ${WP_EMAIL} \
			--role=author \
			--user_pass=${WP_PWD} ;
echo "4"
wp cache flush --allow-root

# it provides an easy-to-use interface for creating custom contact forms and managing submissions, as well as supporting various anti-spam techniques
echo "5"
wp plugin install contact-form-7 --activate --allow-root

# set the site language to English
echo "6"
wp language core install en_US --activate --allow-root

# remove default themes and plugins
echo "7"
wp theme delete twentynineteen twentytwenty --allow-root
echo "8"
wp plugin delete hello --allow-root

# set the permalink structure
wp rewrite structure '/%postname%/' --allow-root

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# start the PHP FastCGI Process Manager (FPM) for PHP version 7.3 in the foreground
exec /usr/sbin/php-fpm7.4 -F -R