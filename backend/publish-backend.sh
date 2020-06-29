#!/bin/bash

sudo dotnet publish src/backend.sln -c Release -o publish
sudo rm -rf /opt/backend
sudo mkdir /opt/backend
sudo cp -a publish/. /opt/backend/
sudo rm -rf publish/
sudo cp backend.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable backend
sudo systemctl restart backend
sudo systemctl status backend
