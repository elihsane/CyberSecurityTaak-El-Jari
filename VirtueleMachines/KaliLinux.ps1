###############################################
###############################################
########## El Ihsane / Jari Roseleth ##########
###############################################
##########    Kali automatisation    ##########
###############################################
###############################################

# Name VM
$VM_NAME = "KaliTaak"

# Create the VM
VBoxManage createvm --name $VM_NAME --ostype KaliLinux --register

# Create the Disk (osboxes)
VBoxManage createmedium disk --filename "C:\Users\${env:USERNAME}\VirtualBox VMs\${VM_NAME}\${VM_NAME}" --size 5120 --format VDI
VBoxManage storagectl ${VM_NAME} --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach ${VM_NAME} --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\VDI Files\Kali Linux 2022.3 (64bit).vdi"

VBoxManage modifyvm $VM_NAME --ioapic on
VBoxManage modifyvm $VM_NAME --memory 2048 --vram 12
VBoxManage modifyvm $VM_NAME --cpus 2

# Network adapters
VBoxManage modifyvm $VM_NAME --nic1 nat
VBoxManage modifyvm $VM_NAME --nic2 bridged

# start vm (met gui)
VBoxManage startvm $VM_NAME --type gui