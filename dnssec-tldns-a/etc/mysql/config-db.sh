# based on https://github.com/sameersbn/docker-mysql/blob/master/entrypoint.sh
set -x
set -e

sed 's/password = .*/password = root/g' -i /etc/mysql/debian.cnf
mysql_install_db --user=mysql
mysqld_safe &
sleep 30
mysql -uroot -e "GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;"

mysql --defaults-file=/etc/mysql/debian.cnf -e "CREATE DATABASE sld CHARSET utf8;"
mysql --defaults-file=/etc/mysql/debian.cnf < /etc/whoisd/sld.sql

mysqladmin --defaults-file=/etc/mysql/debian.cnf shutdown
