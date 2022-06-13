#/bin/bash

#colors
YELLOW='\033[1;33m'
NC='\033[0m' 
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
LRED='\033[1;31m'

apt update
apt install -y figlet toilet
sudo apt -y autoremove

echo -e "${GREEN}"
figlet -f slant "JmantZ's Script"
echo -e "${NC}"

echo -e "${YELLOW}What is the name of your mysql user?${NC}"
read MYSQL_USERNAME

echo -e "${YELLOW}What is the name of your mysql database?${NC}"
read MYSQL_DATABASE_NAME

echo -e "${YELLOW}What is the name of your pterodactyl user?${NC}"
read PTERODACTYL_USER


echo -e "${YELLOW}Remove remove entire pterodactyl panel, including dependencies, packages and files connected to it? (yes) or (no)${NC}"
read COMPLETE_REMOVAL_BOOLEAN

if [ "$COMPLETE_REMOVAL_BOOLEAN" = "yes" ]; then

echo -e "${YELLOW}Deleting pterodactyl user${NC}"
cd /
cd /var/www/pterodactyl
php artisan p:user:delete --user="$PTERODACTYL_USER"

echo -e "${YELLOW}>>Unlinking and disabling redis and pteroq services..${NC}"

unlink /etc/systemd/system/redis.service
unlink /etc/systemd/system/pteroq.service 
sudo systemctl disable --now redis-server
sudo systemctl disable --now pteroq.service

echo -e "${YELLOW}>>Stopping nginx...${NC}"
systemctl stop nginx

echo -e "${YELLOW}>>Disabling wings and docker${NC} "
systemctl disable --now wings
systemctl disable --now docker

echo -e "${YELLOW}>>Deleting redis,php and mariadb repositories${NC}"
add-apt-repository -r -y ppa:ondrej/php
add-apt-repository -r -y ppa:redislabs/redis

echo -e "${YELLOW}>>Deleting database and database user${NC}"
mysql -u root -e "DROP DATABASE IF EXISTS "$MYSQL_DATABASE_NAME";"
mysql -u root -e "DROP USER IF EXISTS "$MYSQL_USERNAME";"

echo -e "${CYAN}>>Deleting Pterodactyl files${NC}"
echo -e "${CYAN}>>Deleting pteroq.service${NC}"
rm /etc/systemd/system/pteroq.service
echo -e "${CYAN}>>Deleting pterodactyl.conf${NC}"
rm /etc/nginx/sites-available/pterodactyl.conf
rm /etc/nginx/sites-enabled/pterodactyl.conf
echo -e "${CYAN}>>Deleting grub${NC}"
rm /etc/default/grub

echo -e "${CYAN}>>Deleting pterodactyl files /etc/pterodacty${NC}"
rm -rf /etc/pterodactyl

echo -e "${CYAN}>>Deleting pterodactyl files /var/www/pterodactyl${NC}"
rm -rf /var/www/pterodactyl

echo -e "${CYAN}>>Deleting pterodactyl files /var/lib/pterodactyl${NC}"
rm rf /var/lib/pterodactyl

echo -e "${CYAN}>>Deleting pterodactyl files /var/log/pterodactyl${NC}"
rm -rf /var/log/pterodactyl

echo -e "${CYAN}>>Deleting Pterodactyl nginx logs${NC}"
rm /var/log/nginx/pterodactyl.app-access.log
rm /var/log/nginx/pterodactyl.app-error.log

sudo apt remove -y certbot
sudo apt remove -y python3-certbot-nginx

echo -e "${YELLOW}>>Removing ${NC}${LRED} ALL${NC} ${YELLOW}Dependencies${NC}"
apt update
apt remove -y redis-server
sudo apt autoremove -y 
apt remove -y redis-tools
sudo apt autoremove -y 
apt remove -y mariadb-server 
sudo apt autoremove -y 
apt remove -y nginx
sudo apt autoremove -y 
apt remove -y git
sudo apt autoremove -y 
apt remove -y unzip
sudo apt autoremove -y 
apt remove -y php8.0
sudo apt autoremove -y 
apt remove -y php8.0-bcmath
sudo apt autoremove -y 
apt remove -y php8.0-cli
sudo apt autoremove -y 
apt remove -y php8.0-common
sudo apt autoremove -y 
apt remove -y php8.0-curl
sudo apt autoremove -y 
apt remove -y php8.0-fpm
sudo apt autoremove -y 
apt remove -y php8.0-gd
sudo apt autoremove -y 
apt remove -y php8.0-mbstring
sudo apt autoremove -y 
apt remove -y php8.0-mysql
sudo apt autoremove -y 
apt remove -y php8.0-xml
sudo apt autoremove -y 
apt remove -y php8.0-zip
sudo apt autoremove  -y 
sudo apt-get purge -y docker-ce-rootless-extras docker-compose-plugin docker-ce docker-ce-cli
sudo apt-get autoremove -y --purge docker-ce-rootless-extras docker-compose-plugin docker-ce docker-ce-cli
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo apt -y autoremove
sudo apt remove -y certbot
sudo apt -y autoremove
sudo apt remove -y python3-certbot-nginx
sudo apt -y autoremove

echo -e "${YELLOW}>>Removing add-apt-repository${NC}"
apt -y remove software-properties-common curl apt-transport-https ca-certificates gnupg

echo -e "${YELLOW}>>Removing composer${NC}"
rm /usr/local/bin/composer


rm -rf /etc/apt/sources.list.d/
cd /
mkdir /etc/apt/sources.list.d/

apt remove -y figlet toilet
sudo apt -y autoremove

echo -e "${GREEN}PANEL HAS BEEN FULLY UNINSTALLED${NC}"
fi
sleep 5
