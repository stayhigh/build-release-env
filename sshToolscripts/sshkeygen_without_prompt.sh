#!/bin/sh

MACOSX="192.168.136.128"
sudo apt-get -y install sshpass &&
yes |ssh-keygen -f ~/.ssh/id_rsa  -t rsa -N ''
ssh-add
sshpass -p 29906219 sudo ssh-copy-id -i ~/.ssh/id_rsa.pub stayhigh@$MACOSX
