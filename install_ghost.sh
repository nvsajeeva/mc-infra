#!/bin/bash
# https://ghost.org/docs/install/ubuntu/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo useradd -d /home/appuser -s /bin/bash appuser
sudo usermod -aG sudo appuser
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt update -y
sudo apt install ruby-full -y
sudo apt install wget -y
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo service codedeploy-agent start
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn -y
sudo apt-get install -y nginx
sudo ufw allow 'Nginx Full'
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash
sudo apt-get install -y nodejs
sudo npm install ghost-cli@latest -g
sudo apt-get install awscli -y
sudo touch /etc/rc.local
sudo chmod +x /etc/rc.local
sudo bash -c 'echo "aws codepipeline start-pipeline-execution --name mc-deploy-pipeline --region us-east-1" > /etc/rc.local'
sudo mkdir -p /var/www/sitename
sudo chown appuser:appuser /var/www/sitename
sudo chmod 775 /var/www/sitename
sudo mkdir /home/appuser
sudo chown appuser:appuser /home/appuser
sudo su root -c  "echo 'appuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
cd /var/www/sitename
#sudo su ghost -c 'ghost install'
sudo su appuser -c 'ghost install \
    --url      "http://blog.meta-carbon.click" \
    --db "mysql" \
    --dbhost "${endpoint}" \
    --dbuser "${username}" \
    --dbpass "${password}" \
    --dbname "mc" \
    --process systemd \
    --no-prompt'

#    --admin-url "http://mc.com/admin" \