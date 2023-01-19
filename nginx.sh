#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "<h1>Welcome to DevOps Class</h1>" > /var/www/html/index.html
INSTNACE_NAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
echo "<h2>You landed on $INSTNACE_NAME</h1>" >> /var/www/html/index.html