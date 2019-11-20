#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"

#Utils
sudo apt-get install nginx