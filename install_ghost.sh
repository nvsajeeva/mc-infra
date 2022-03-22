#!/bin/bash
# https://ghost.org/docs/install/ubuntu/
sudo useradd -d /home/ghost -s /bin/bash ghost
sudo usermod -aG sudo ghost
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y nginx
sudo ufw allow 'Nginx Full'
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash
sudo apt-get install -y nodejs
sudo npm install ghost-cli@latest -g
sudo mkdir -p /var/www/sitename
sudo chown ghost:ghost /var/www/sitename
sudo chmod 775 /var/www/sitename
sudo mkdir /home/ghost
sudo chown ghost:ghost /home/ghost
cd /var/www/sitename
#sudo su ghost -c 'ghost install'