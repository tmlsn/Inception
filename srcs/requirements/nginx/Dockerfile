FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install -y nginx
RUN apt-get install -y curl
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN apt-get install -y openssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mmhaya.42.fr/UID=mmhaya"

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]