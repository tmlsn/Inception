#!/bin/bash

service mariadb start;

echo $MYSQL_DB
echo $MYSQL_USER
echo $MYSQL_HOST

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
echo "1"
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PW}';"
echo "2"
mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PW}';"
echo "3"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PW}';"
echo "4"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MYSQL_ROOT_PW} shutdown

exec mysqld_safe

echo "MariaDB database and user were created successfully !"
