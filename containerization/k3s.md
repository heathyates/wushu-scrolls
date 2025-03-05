# NVIDIA Jetson Documentation 

## Table of Contents
1. [Introduction](#introduction)
2. [K3s Installation]()


## Introduction 

K3s is a lightweight k8s distribution created by Rancher Labs. It abstracts the complexity normally associated with k8s by 
allowing the reader the ability to install kubernetes with a single binary. Compared to other K8s solutions such as microk8s, K3s was chosen for it's small size and ease of installation. For further reading, please see the official documents [here](https://k3s.io/). In addition, [here](https://www.youtube.com/watch?v=PziYflu8cB8) is a concise explaination of k8s. 

## Caveats 

This walkthrough assumes a primary node and a secondary node. If the reader has more secondary nodes, it is beyond the scope of this documentation. However, it should in principle be a variation of a theme and the steps for secondary node is duplicated for any arbitrary amount of nodes. 



## Pre-requisites 

The following ports were allowed on the primary node: 
```
	sudo ufw allow 22/tcp        # SSH
	sudo ufw allow 6443/tcp      # K3s API
	sudo ufw allow 8472/udp      # Flannel VXLAN
	sudo ufw allow 10250/tcp     # Kubelet port
```

Next, the following ports were open on the secondary node: 
```
	sudo ufw allow 22/tcp        # SSH
	sudo ufw allow 8472/udp      # Flannel VXLAN
  sudo ufw allow 10250/tcp     # Kubelet port
```

Once this has been installed, we run the system updates on both machines: 
```
	sudo apt-get update
	sudo apt-get upgrade -y
  sudo reboot
```

## K3s Installation 

First, on the primary node, we install as follows: 

```
	sudo apt install curl
	curl -sfL https://get.k3s.io | sh - systemctl status k3s
````

The following will confirm it has been installed: 

```
sudo k3s kubectl get nodes
````

Second, obtain the token for the secondary node as follows: 

```
sudo cat /var/lib/rancher/k3s/server/node-token
````


## K3 Common Issues 

The following were issues encountered during installation of k3s. 

### Grant User Access to k3s kubeconfig

If you see this error, you need to grant better access to `kubctl` as follows: 
```
WARN[0000] Unable to read /etc/rancher/k3s/k3s.yaml, please start server with --write-kubeconfig-mode or --write-kubeconfig-group to modify kube config permissions
error: error loading config file "/etc/rancher/k3s/k3s.yaml": open /etc/rancher/k3s/k3s.yaml: permission denied
```


Let us see about fixing this error. The issue is bascially permissions with the user. 

```
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
sudo chown $USER:$USER /etc/rancher/k3s/k3s.yaml
```

For KUBECONFIG, you do the following: 
`export KUBECONFIG=/etc/rancher/k3s/k3s.yaml`

Now, you should be able to see the nodes with `kubctl get nodes`. There is a catch, the above is not a permenant fix. If you want to bake it in, you do the following: 

```
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
source ~/.bashrc
```



# Misc Commands

Suppose you want to see the pods that are running: 
`kubectl get pods -A` 


## References 

- [Dashboard Releases](https://github.com/kubernetes/dashboard/releases)