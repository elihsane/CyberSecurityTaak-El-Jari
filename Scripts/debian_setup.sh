#!/bin/bash

###############################################
###############################################
########## El Ihsane / Jari Roseleth ##########
###############################################
######### Cybersecurity debian script #########
###############################################
###############################################

sudo apt update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg -y

#install docker
sudo wget https://download.docker.com/linux/debian/gpg
sudo apt-key add gpg
echo 'deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable' | sudo tee -a /etc/apt/soruces.list.d/docker.list 

sudo apt update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#install apache
sudo docker pull httpd:2.4.49

#config apache
sudo docker run --name vuln-httpd -p 8080:80 -d httpd:2.4.49
sudo docker cp vuln-httpd:/usr/local/apache2/conf/httpd.conf .

sed '250s/denied/granted/' httpd.conf > httpd.new.conf
sudo docker cp httpd.new.conf vuln-httpd:/usr/local/apache2/conf/httpd.conf
sudo docker container restart vuln-httpd

#modify line in httpd.conf
# sudo nano httpd.conf Require all denied -> Require all granted

#config for RCE
sudo docker cp vuln-httpd:/usr/local/apache2/conf/httpd.conf .

sed '184,187s/#//' httpd.conf > httpd.new.conf
sudo docker cp httpd.new.conf vuln-httpd:/usr/local/apache2/conf/httpd.conf
sudo docker container restart vuln-httpd
