#!/bin/bash

wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh

. ./dotnet-install.sh -c 3.1
sudo ln -s $bin_path/dotnet /usr/local/bin/dotnet
sudo rm dotnet-install.sh
