#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo systemctl stop nginx
rm -f /etc/nginx/sites-enabled/default
#wget https://github.com/mkmrah/helm-airflow/releases/download/untagged-6e7527687d744c4d25b8/schematics-blueprint-1.0.tgz -P /tmp/
#tar -xzf /tmp/schematics-blueprint-1.0.tgz -C /tmp

wget https://github.com/mkmrah/bash_script/releases/download/V1.3/schematics-blueprint-1.1.tgz -P /tmp/
tar -xzf /tmp/schematics-blueprint-1.1.tgz -C /tmp

#mkdir /var/schematics-blueprint
mv /tmp/schematics-blueprint /var/www/schematics-blueprint
mv /var/www/schematics-blueprint/blueprint.conf /etc/nginx/conf.d/
#chmod 0755 /var/schematics-blueprint/
#nginx -s reload
sudo systemctl restart nginx
sudo nginx -s reload
