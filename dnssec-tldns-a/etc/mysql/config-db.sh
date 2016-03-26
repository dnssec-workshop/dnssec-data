# based on https://github.com/sameersbn/docker-mysql/blob/master/entrypoint.sh
set -x
set -e

sed -i 's/password = .*/password =/' /etc/mysql/debian.cnf
sed -i 's/^log_error/# log_error/' /etc/mysql/mysql.conf.d/mysqld.cnf
cat > /etc/mysql/mysql.conf.d/mysql-skip-name-resolv.cnf <<EOF
[mysqld]
skip_name_resolve
EOF

mysql_install_db --user=mysql

cd /usr ; mysqld &
sleep 15
mysqladmin -u root status
mysql -uroot -e "GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '' WITH GRANT OPTION;"
mysql --defaults-file=/etc/mysql/debian.cnf -e "GRANT ALL PRIVILEGES ON *.* TO root@localhost IDENTIFIED BY 'root'"
mysql --defaults-file=/etc/mysql/debian.cnf -e "GRANT ALL PRIVILEGES ON *.* TO root@127.0.0.1 IDENTIFIED BY 'root'"
mysql --defaults-file=/etc/mysql/debian.cnf -e "CREATE DATABASE sld CHARSET utf8;"
mysql --defaults-file=/etc/mysql/debian.cnf sld < /etc/whoisd/sld.sql
mysqladmin --defaults-file=/etc/mysql/debian.cnf shutdown
