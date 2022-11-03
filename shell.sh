#!/bin/bash

# microsoft package
sudo wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

#moby engine
sudo apt-get update
yes | sudo apt-get install moby-engine

#iot defender
sudo apt-get update
yes | sudo apt-get install aziot-edge defender-iot-micro-agent-edge

