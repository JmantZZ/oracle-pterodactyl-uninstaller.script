#/bin/bash

#colors
YELLOW='\033[1;33m'
NC='\033[0m' 
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
LRED='\033[1;31m'

unlink /etc/systemd/system/redis.service
unlink /etc/systemd/system/pteroq.service 
sudo systemctl disable --now redis-server
sudo systemctl disable --now pteroq.service
systemctl stop nginx
systemctl disable --now wings
systemctl disable --now docker

echo -e "${YELLOW}Removing add-apt-repositories${NC}"
add-apt-repository -r -y ppa:ondrej/php
add-apt-repository -r -y ppa:redislabs/redis


echo -e "${YELLOW}Removing pterodactyl files${NC}"
rm -rf -p /var/www/pterodactyl


mysql -u root -e "DROP DATABASE IF EXISTS panel;"
mysql -u root -e "DROP USER IF EXISTS pterodactyl;"

rm /etc/systemd/system/pteroq.service

rm /etc/nginx/sites-available/pterodactyl.conf

rm -rf /etc/default/grub

rm /etc/pterodactyl


rm -rf /etc/systemd/system/wings.service

rm /var/lib/pterodactyl

sudo apt remove -y certbot
sudo apt remove -y python3-certbot-nginx

echo -e "${YELLOW}Removing Dependencies${NC}"
apt update
apt remove -y redis-server
apt remove -y redis-tools
apt remove -y php8.1
apt remove -y php8.1-zip
apt remove -y php8.1-xml
apt remove -y php8.1-mysql
apt remove -y php8.1-mbstring
apt remove -y php8.1-gd
apt remove -y php8.1-fpm 
apt remove -y php8.1-curl
apt remove -y php8.1-common
apt remove -y php8.1-cli
apt remove -y php8.1-bcmath
apt remove -y mariadb-server 
apt remove -y nginx
apt remove -y git
apt remove -y unzip

echo -e "${YELLOW}Removing add-apt-repository${NC}"
apt -y remove software-properties-common curl apt-transport-https ca-certificates gnupg

echo -e "${YELLOW}Removing composer${NC}"
rm /usr/local/bin/composer