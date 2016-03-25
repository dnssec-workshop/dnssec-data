# based on https://github.com/sameersbn/docker-mysql/blob/master/entrypoint.sh
set -x
set -e

sed -i 's/password = .*/password = root/g' /etc/mysql/debian.cnf
sed -i 's/^log_error/# log_error/' /etc/mysql/mysql.conf.d/mysqld.cnf
cat > /etc/mysql/mysql.conf.d/mysql-skip-name-resolv.cnf <<EOF
[mysqld]
skip_name_resolve
EOF

mysql_install_db --user=mysql
mysqld_safe &
sleep 60

mysql -uroot -proot -e "GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;"

mysql --defaults-file=/etc/mysql/debian.cnf -e "CREATE DATABASE sld CHARSET utf8;"
mysql --defaults-file=/etc/mysql/debian.cnf < /etc/whoisd/sld.sql

mysqladmin --defaults-file=/etc/mysql/debian.cnf shutdown
