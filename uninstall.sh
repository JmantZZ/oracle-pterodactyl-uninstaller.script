#/bin/bash

#colors
YELLOW='\033[1;33m'
NC='\033[0m' 
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
LRED='\033[1;31m'

rm /etc/apt/sources.list.d/mariadb.list.old_1
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

mysql -u root -e "DROP DATABASE IF EXISTS panel;"
mysql -u root -e "DROP USER IF EXISTS pterodactyl;"

rm /etc/systemd/system/pteroq.service
rm /etc/nginx/sites-available/pterodactyl.conf
rm /etc/nginx/sites-enabled/pterodactyl.conf
rm /etc/default/grub
php artisan php artisan p:user:delete --stam

rm -rf /etc/pterodactyl

rm /etc/systemd/system/wings.service
rm -rf /var/lib/pterodactyl
rm -rf /var/www/pterodactyl

sudo apt remove -y certbot
sudo apt remove -y python3-certbot-nginx

echo -e "${YELLOW}Removing Dependencies${NC}"
apt update
apt remove -y redis-server
sudo apt autoremove
apt remove -y redis-tools
sudo apt autoremove
apt remove -y php8.1
sudo apt autoremove
apt remove -y php8.1-zip
sudo apt autoremove
apt remove -y php8.1-xml
sudo apt autoremove
apt remove -y php8.1-mysql
sudo apt autoremove
apt remove -y php8.1-mbstring
sudo apt autoremove
apt remove -y php8.1-gd
sudo apt autoremove
apt remove -y php8.1-fpm 
sudo apt autoremove
apt remove -y php8.1-curl
sudo apt autoremove
apt remove -y php8.1-common
sudo apt autoremove
apt remove -y php8.1-cli
sudo apt autoremove
apt remove -y php8.1-bcmath
sudo apt autoremove
apt remove -y mariadb-server 
sudo apt autoremove
apt remove -y nginx
sudo apt autoremove
apt remove -y git
sudo apt autoremove
apt remove -y unzip
sudo apt autoremove
apt remove -y php8.0
apt remove -y php8.0-bcmath
apt remove -y php8.0-cli
apt remove -y php8.0-common
apt remove -y php8.0-curl
apt remove -y php8.0-fpm
apt remove -y php8.0-gd
apt remove -y php8.0-mbstring
apt remove -y php8.0-mysql
apt remove -y php8.0-xml
apt remove -y php8.0-zip
sudo apt autoremove

sudo apt-get purge -y docker-ce-rootless-extras docker-compose-plugin docker-ce docker-ce-cli
sudo apt-get autoremove -y --purge docker-ce-rootless-extras docker-compose-plugin docker-ce docker-ce-cli
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo apt autoremove
echo -e "${YELLOW}Removing add-apt-repository${NC}"
apt -y remove software-properties-common curl apt-transport-https ca-certificates gnupg

echo -e "${YELLOW}Removing composer${NC}"
rm /usr/local/bin/composer