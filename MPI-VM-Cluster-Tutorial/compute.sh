#Sources:
# 1. https://www.geeksforgeeks.org/creating-an-mpi-cluster/
# 2. https://www.open-mpi.org/doc/v3.0/man1/mpiexec.1.php
# 3. https://www.cyberciti.biz/faq/linux-get-number-of-cpus-core-command/

sudo apt install openmpi-bin openssh-server nfs-kernel-server nfs-common -y
# Create host file
# sudo nano /etc/hosts
# ip \t head
# ip \t compute1

sudo adduser mpiuser
sudo usermod -aG sudo mpiuser #Appends mpiuser to sudoers

su - mpiuser
ssh-keygen -t ecdsa
cd .ssh/
cat id_ecdsa.pub >> authorized_keys
ssh-copy-id head

#Test login: ssh head
