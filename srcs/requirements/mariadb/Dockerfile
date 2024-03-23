FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/configuresql.sh ./
RUN chmod +x ./configuresql.sh

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld/ && chmod -R 755 /run/mysqld/
RUN mkdir -p /var/lib/mysql && chown mysql:mysql /var/lib/mysql/ && chmod -R 755 /var/lib/mysql/

EXPOSE 3306

ENTRYPOINT ["bash", "./configuresql.sh"]