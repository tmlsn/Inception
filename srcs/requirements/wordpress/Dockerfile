FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install php7.4 php-fpm php-mysql -y

RUN rm -rf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update -y
RUN apt-get install default-mysql-client -y

RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 9000

COPY ./tools/wpscript.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wpscript.sh


ENTRYPOINT [ "bash", "./usr/local/bin/wpscript.sh" ]
