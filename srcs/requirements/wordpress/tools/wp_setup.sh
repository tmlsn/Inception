#!/bin/bash
#set -eux

cd /var/www/html/wordpress

if ! wp core is-installed --allow-root; then

wp config create	--allow-root --dbname=${MYSQL_DATABASE} \
			--dbuser=${MYSQL_USER} \
			--dbpass=${MYSQL_PASSWORD} \
			--dbhost=${MYSQL_HOSTNAME} \
			--url=https://${DOMAIN_NAME};

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

wp plugin install classic-editor --activate --allow-root

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