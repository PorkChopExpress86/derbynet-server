#!/bin/bash

# Update the server packages
sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y

# Install dependent packages
sudo apt-get install -y apt-transport-https

# Add derbynet gpg key
wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | \
 sudo tee /usr/share/keyrings/derbynet-archive-keyring.gpg > /dev/null

# Add repo for derbynet stable packages
echo "deb [arch=all signed-by=/usr/share/keyrings/derbynet-archive-keyring.gpg] " \
 " https://jeffpiazza.org/derbynet/debian stable main" | \
 sudo tee /etc/apt/sources.list.d/derbynet.list > /dev/null

# Update apt package repos
sudo apt-get update

# Install server package
sudo apt-get install derbynet-* -y

# Install snap and update snap core
sudo snap install core; sudo snap refresh core

# Install certbot via snap
sudo snap install --classic certbot

# Link certbot command to the correct location
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# ufw firewall limit ssh connections
sudo ufw limit ssh

# ufw firewall allow 'Nginx Full'
sudo ufw allow 'Nginx Full'

# Setup certbot for your domain
sudo certbot --nginx -d pack1177.tk -d www.pack1177.tk
