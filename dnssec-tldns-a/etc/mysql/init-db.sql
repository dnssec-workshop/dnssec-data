USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("root") WHERE user='root'
CREATE DATABASE sld CHARSET utf8;
USE sld;
-- import data from sld below
