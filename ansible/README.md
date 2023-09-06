## Installation of ansible in Ubuntu 20.04

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```
Default directory for ansible is:
/etc/ansible

After ansible installation, it creates below in /etc/ansible directory:
```bash
datta@a1-test-dev-01-vm:/etc/ansible$ ls -lrt
-rw-r--r-- 1 root root 1018 Oct 11  2022 hosts
-rw-r--r-- 1 root root  614 Oct 11  2022 ansible.cfg
drwxr-xr-x 2 root root 4096 Oct 25  2022 roles
```
