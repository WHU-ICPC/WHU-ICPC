#!/bin/bash

sudo mkdir -p /tmp/acmbackup ; sudo rm -rf /tmp/acmbackup ; sudo mkdir -p /tmp/acmbackup

sudo cp -r /home/acm/.backup/acm /tmp/acmbackup/
sudo rm -rf /home/acm
sudo cp -r /tmp/acmbackup/. /home
sudo mkdir -p /home/acm/.backup
sudo cp -r /tmp/acmbackup/. /home/acm/.backup

sudo chmod -R 755 /home/acm
sudo chown -R acm:acm /home/acm 
sudo chown -R root:root /home/acm/.backup
sudo chown -R root:root /home/acm/.scripts
sudo chmod -R 700 /home/acm/.backup
sudo chmod -R 700 /home/acm/.scripts
