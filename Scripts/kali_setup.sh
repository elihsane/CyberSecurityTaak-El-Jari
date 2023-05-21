#!/bin/bash

###############################################
###############################################
########## El Ihsane / Jari Roseleth ##########
###############################################
#########  Cybersecurity kali script  #########
###############################################
###############################################

echo "auto eth1" | sudo tee -a /etc/network/interfaces
echo "iface eth1 inet static" | sudo tee -a /etc/network/interfaces
echo "address 192.168.1.61" | sudo tee -a /etc/network/interfaces
echo "netmask 255.255.255.0" | sudo tee -a /etc/network/interfaces

sudo ifup eth1
sudo systemctl restart NetworkManager

echo "Script completed"