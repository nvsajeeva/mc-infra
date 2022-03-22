#!/bin/bash
# https://ghost.org/docs/install/ubuntu/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo useradd -d /home/appuser -s /bin/bash appuser
sudo usermod -aG sudo appuser
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y nginx
sudo ufw allow 'Nginx Full'
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash
sudo apt-get install -y nodejs
sudo npm install ghost-cli@latest -g
sudo mkdir -p /var/www/sitename
sudo chown appuser:appuser /var/www/sitename
sudo chmod 775 /var/www/sitename
sudo mkdir /home/appuser
sudo chown appuser:appuser /home/appuser
sudo su root -c  "echo 'appuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
cd /var/www/sitename
#sudo su ghost -c 'ghost install'
sudo su appuser -c 'ghost install \
    --url      "http://mc.com" \
    --admin-url "http://admin.mc.com" \
    --db "mysql" \
    --dbhost "${endpoint}" \
    --dbuser "${username}" \
    --dbpass "${password}" \
    --dbname "mc" \
    --process systemd \
    --no-prompt'