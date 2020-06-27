#!/bin/bash
# sudo apt update
# sudo apt install -y nginx

# sudo ufw allow 'Nginx HTTP'
# systemctl status nginx

# ip addr show | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

echo "Nginx has been installed"
echo "Uncomment line 'server_names_hash_bucket_size 64;' in /etc/nginx/nginx.conf"
echo "For futher configuration see: https://www.digitalocean.com/community/tutorials/nginx-ubuntu-18-04-ru"

domain="dominion3.com.ua"

sudo mkdir -p /var/www/$domain
sudo chown -R $USER:$USER /var/www/$domain
sudo cp nginx.conf /etc/nginx/sites-available/$domain
sudo ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/

sudo mkdir /etc/systemd/system/nginx.service.d
echo "[Service]
Restart=always" >> /etc/systemd/system/nginx.service.d/override.conf

sudo systemctl daemon-reload
sudo systemctl restart nginx
