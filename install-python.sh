#!/bin/bash
sudo apt update
sudo apt -y upgrade

python3 -V

if [ $? != 0 ]; then
sudo yum install -y https://repo.ius.io/ius-release-el7.rpm
sudo yum update
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip
fi

pip

if [ $? != 0 ]; then
sudo apt install -y python3-pip
fi

sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-virtualenv
