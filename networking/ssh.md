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


## References
TBD