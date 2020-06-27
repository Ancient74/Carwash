#!/bin/bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib

sudo -u postgres createuser --interactive

echo "Enter following command to continue installation"
echo "sudo adduser <db-username>"
echo "sudo -u postgres createdb <db-username>"
