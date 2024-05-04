#!/bin/bash

sudo mkdir -p /tmp/acmbackup ; sudo rm -rf /tmp/acmbackup ; sudo mkdir -p /tmp/acmbackup
sudo mkdir -p /home/acm/.backup ; sudo rm -rf /home/acm/.backup ;

sudo cp -r /home/acm /tmp/acmbackup/
sudo mkdir -p /home/acm/.backup
sudo cp -r /tmp/acmbackup/. /home/acm/.backup/
