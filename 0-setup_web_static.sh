#!/usr/bin/env bash
# This script sets up web servers for the deployment of web_static

# Update and Upgrade
sudo apt-get -y update
sudo apt-get -y upgrade

# Install Nginx
sudo apt-get -y install nginx

# Create Directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create a Test HTML File
echo "<html>
    <head>
    </head>
    <body>
        Holberton School
    </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create Symbolic Link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set Ownership and Permissions
sudo chown -hR ubuntu:ubuntu /data
sudo chmod -R 755 /data

# Configure Nginx
sudo sed -i '/listen 80 default_server/a location /hbnb_static/ { alias /data/web_static/current/; }' /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart
