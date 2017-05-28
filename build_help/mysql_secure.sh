#!/bin/bash

mysqladmin -u root password linux
mysql -u root -plinux -e "CREATE USER 'oai'@'127.0.0.1' IDENTIFIED BY 'linux';"
mysql -u root -plinux -e "GRANT ALL PRIVILEGES ON oai_db.* to 'oai'@'127.0.0.1';"
mysql -u root -plinux -e "FLUSH PRIVILEGES;"
mysql -u root -plinux oai_db < oai.db.sql
