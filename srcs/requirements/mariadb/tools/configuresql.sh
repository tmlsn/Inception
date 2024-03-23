#!bin/bash

service mariadb start;


#logs for debug:looks like env isn't reachable
echo $MYSQL_DATABASE
echo $MYSQL_USER
echo $MYSQL_HOSTNAME

# log into MariaDB as root and create database and the user
mysqladmin -u root password ${MYSQL_ROOT_PASSWORD}

mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
#mysqladmin -u root shutdown
exec mysqld_safe

#print status
echo "MariaDB database and user were created successfully! "