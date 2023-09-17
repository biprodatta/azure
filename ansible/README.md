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
## useful commands of ansible:

```bash
# get ansible version
ansible --version
# get all active hosts
ansible all --list-hosts
ansible all -m ping
ansible-playbook file_content_change.yaml -i /etc/ansible/inventories/master.ini -e adhoc_host=abc\* -u username --tags "post_installation_run" --limit "!host"
```
For all hosts it is mendatory to enable passowrdless login for ansible server
for that you need to go to /home/datta/.ssh directory
it will have below files:
```bash
datta@a1-test-dev-01-vm:/etc/ansible$ cd /home/datta/.ssh/
datta@a1-test-dev-01-vm:~/.ssh$ ll
drwx------ 2 datta datta 4096 Sep  6 06:38 ./
drwxr-xr-x 7 datta datta 4096 Sep  6 06:22 ../
-rw------- 1 datta datta    0 Sep  6 01:59 authorized_keys
-rw------- 1 datta datta 1831 Sep  6 06:38 id_rsa
-rw-r--r-- 1 datta datta  405 Sep  6 06:38 id_rsa.pub
-rw-r--r-- 1 datta datta  222 Sep  6 06:25 known_hosts
```
if you cant see id_rsa and id_rsa.pub, then you need to create rsa key using "ssh-keygen" command. then both of those file will be there in /home/$USER/.ssh/ directory.

once both files are there in your ansible host server, 
either use option 1 or option 2:
1) just run 
    cat id_rsa.pub
    then copy the content of it and login into all host servers and go to same 
    /home/USER/.ssh folder
    run : vi authorized_keys 
    save file using [escape] then, wq!
2) run below command :
   yum install sshpass -y
   SSHPASS=Passpwrd_of_distination_server sshpass –e ssh-copy-id -i /Users/biprodatta/.ssh/id_rsa.pub ansibleuser@destination_server_ip

then login again into ansible server and try below:
ssh USER@host-ip
if you are able to login then you have successfully configured passwordless login.

Then run below command to check if ansible is configured properly from networing prospective.

```bash
datta@a1-test-dev-01-vm:~/.ssh$ ansible all -m ping
20.172.240.209 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

