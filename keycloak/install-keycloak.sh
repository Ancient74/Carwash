#!/bin/bash
echo "This script installs keycloak and perform some intinal configuration"

sudo apt-get update
sudo apt-get install default-jdk -y

sudo wget https://downloads.jboss.org/keycloak/10.0.2/keycloak-10.0.2.tar.gz


sudo tar -xvzf keycloak-10.0.2.tar.gz
sudo mv keycloak-10.0.2 /opt/keycloak
sudo cp realm.json /opt/keycloak/
sudo cp keycloak.service /etc/systemd/system/

sudo rm keycloak-10.0.2.tar.gz

sudo systemctl daemon-reload
sudo systemctl enable keycloak
sudo systemctl start keycloak
sudo systemctl status keycloak

echo "Keycloak has been installed. You can log in using 'carwash-admin' 'temp' credentials"
