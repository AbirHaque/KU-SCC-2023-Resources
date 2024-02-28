#Sources:
# 1. https://www.geeksforgeeks.org/creating-an-mpi-cluster/
# 2. https://www.open-mpi.org/doc/v3.0/man1/mpiexec.1.php
# 3. https://www.cyberciti.biz/faq/linux-get-number-of-cpus-core-command/

sudo apt install openmpi-bin openssh-server nfs-kernel-server nfs-common -y
# Create host file
# sudo nano /etc/hosts
# ip \t head
# ip \t compute1
# ip \t compute2

sudo adduser mpiuser
sudo usermod -aG sudo mpiuser #Appends mpiuser to sudoers

su - mpiuser
ssh-keygen -t ecdsa
cd .ssh/
cat id_ecdsa.pub >> authorized_keys
ssh-copy-id compute1
ssh-copy-id compute2

#Test login: ssh compute1

sudo nano /etc/exports
# Append /home/mpiuser/cloud *(rw,sync,no_root_squash,no_subtree_check)

mkdir cloud
exportfs -a
sudo mount -t nfs head:/home/mpiuser/cloud ~/cloud
df -h  #Check mounted directories

nano /etc/fstab #So we don't have to manually mount shared directory eeach reboot
#MPI CLUSTER SETUP
#head:/home/mpiuser/cloud /home/mpiuser/cloud nfs



nano hostfile.txt
#head
#compute1
#compute2

mpicc test_mpi.c -o test_mpi
mpiexec -np 18 -hostfile hostfile.txt ./test_mpi
