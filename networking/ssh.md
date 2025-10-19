# Python Classes Cheat Sheet

## Table of Contents
1. [Introduction](#introduction)
2. [Config](#main-class)
3. [References](#main-class)

## Introduction

TBD

## Config 

This file allows aliases to connect to a external server. 

```
Host krelln
    HostName 192.168.1.2
    User hlyates
    Port 22
    IdentityFile ~/.ssh/id_ed25519

Host arvon
    HostName 192.168.1.3
    User hlyates
    Port 22
    IdentityFile ~/.ssh/id_ed25519

```

## Add pubkey to authorized key 

Assume you have generated `id_ed25519` pubkey. SSH into the remote device you want to add the key to. 
```
mkdir .ssh
chmod 700 .ssh
cd .ssh/
sudo vi authorized_keys
sudo chmod 600 authorized_keys
```

In addition, you must now create a user for the remote machine to use with the config file: 
```
sudo adduser hlyates
sudo usermod -aG sudo hlyates
```

Manually add your `id_ed25519` to the `authorized_keys`. Now, on the local machine, add the following
alias to the `config` file inside of `.ssh` as follows: 

```
Host salusasecundus
    HostName 192.168.4.53
    User hlyates
    Port 22
    IdentityFile ~/.ssh/id_ed25519
```

## Add existing pubkey to a machine for root and user

First, us the command `scp id_ed25519.pub user@123.45.6.78:/home/user/.ssh`. 
Second, on the host machine, switch to host `sudo -i`
Third, run `mkdir -p /root/.ssh` and then `chmod 700 /root/.ssh`
Fourth, run `cat /home/hlyates/.ssh/id_ed25519.pub >> /root/.ssh/authorized_keys` and then `chmod 600 /root/.ssh/authorized_keys`
Five, `systemctl restart ssh`


Similar to root, the steps are the same except we are going to add the `pubkey` to `user`. 

```
scp id_ed25519.pub user@123.45.6.78:/home/user/.ssh
mkdir -p /home/user/.ssh
chmod 700 /home/user/.ssh

cat ~/.ssh/id_ed25519.pub >> /home/user/.ssh/authorized_keys
chmod 600 /home/user/.ssh/authorized_keys
chown -R user:user /home/user/.ssh
```

Please note that `user` is whatever the username is on the device. 



## References
TBD