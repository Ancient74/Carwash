#!/bin/bash

sudo cp token-validation.service /etc/systemd/system/
virtualenv tokenvirtualenv
sudo cp *.py tokenvirtualenv
sudo cp requirements.txt tokenvirtualenv

source tokenvirtualenv/bin/activate

sudo tokenvirtualenv/bin/pip3 install -r requirements.txt

sudo mkdir /opt/token-validation-service
sudo cp -r tokenvirtualenv/ /opt/token-validation-service/tokenvirtualenv
sudo rm -rf tokenvirtualenv/

sudo systemctl daemon-reload
sudo systemctl enable token-validation
sudo systemctl start token-validation
sudo systemctl status token-validation
