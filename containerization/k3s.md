


## Grant User Access to k3s kubeconfig

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

## Helm

Helm is a tool in the k8s ecosystem designed to assist with the managment of applications in the k8s ecosystem. 

In general, here are the use cases for helm: 

1. Package Management (aka charts)
2. Templating (manifests used to deploy applications)
3. Dependency management (Helps with different charts)
4. Configuration Management (values.yaml)

Since we have ubuntu, we can download with the following: 

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

If successful, you should see something as follows: 
`version.BuildInfo{Version:"v3.17.1", GitCommit:"980d8ac1939e39138101364400756af2bdee1da5", GitTreeState:"clean", GoVersion:"go1.23.5"}`

## Kubernetes Dashboard 

The k8s dashboard. First, we look at what version of k3s we have: 

`sudo k3s --version`

Since we have `v1.31`, then it follows that we should consider `7.9.0` as specified [here](https://github.com/kubernetes/dashboard/releases?page=2)

Next, we add k8s dashboard to the helm repo as follows: 

```
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update
```

Now you are ready to install. You run this command: 

`helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --version 7.10.0 --namespace kubernetes-dashboard --create-namespace`

Here is what you can use to get the services as follows: 
`kubectl -n kubernetes-dashboard get svc`


You should see an output as follows: 

```
Congratulations! You have just installed Kubernetes Dashboard in your cluster.

To access Dashboard run:
  kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

NOTE: In case port-forward command does not work, make sure that kong service name is correct.
      Check the services in Kubernetes Dashboard namespace using:
        kubectl -n kubernetes-dashboard get svc

Dashboard will be available at:
  https://localhost:8443
```  

Now we need to make sure we can access this dashboard as indicated via this issue [here](https://stackoverflow.com/questions/75643571/internal-server-error-when-attempting-to-connect-to-kubernetes-dashboard-tls). 

```
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: websecure
    traefik.ingress.kubernetes.io/router.tls: "true"
spec:
  ingressClassName: traefik
  rules:
  - host: dashboard.krelln.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: kubernetes-dashboard-kong-proxy
            port:
              number: 443
EOF
```

Here is what exposes the ports we need:
```
kubectl -n kubernetes-dashboard expose deployment kubernetes-dashboard-kong --type=LoadBalancer --name=dashboard-lb --port=443 --target-port=844343
service/dashboard-lb exposed

kubectl -n kubernetes-dashboard get svc dashboard-lb
```

Now we create the token as follows: 

```
kubectl -n kubernetes-dashboard create serviceaccount dashboard-admin-sa
serviceaccount/dashboard-admin-sa created

kubectl -n kubernetes-dashboard create clusterrolebinding dashboard-admin-sa \
    --clusterrole=cluster-admin \
    --serviceaccount=kubernetes-dashboard:dashboard-admin-sa
clusterrolebinding.rbac.authorization.k8s.io/dashboard-admin-sa created

kubectl -n kubernetes-dashboard create token dashboard-admin-sa
```

You can now navigate via the url as follows: `https://dashboard.krelln.local`


## Windows

Using the command prompt with windows, do the following: 
```
cd C:\Windows\System32\drivers\etc\code . 
```

You will have `vscode` and then you can add the following to the file: 

`192.168.1.2 dashboard.krelln.local`


## Check Logs for errors

API logs
`kubectl -n kubernetes-dashboard logs deployment/kubernetes-dashboard-api`

Auth logs
`kubectl -n kubernetes-dashboard logs deployment/kubernetes-dashboard-auth`

Kong (gateway) logs
`kubectl -n kubernetes-dashboard logs deployment/kubernetes-dashboard-kong`

Dashboard logs
`kubectl -n kubernetes-dashboard logs deployment/kubernetes-dashboard-web`

Check if web can reach api and api can reach auth 
```
kubectl -n kubernetes-dashboard exec -it deployment/kubernetes-dashboard-web -- curl -k https://kubernetes-dashboard-api:443
kubectl -n kubernetes-dashboard exec -it deployment/kubernetes-dashboard-api -- curl -k https://kubernetes-dashboard-auth:443
```


# Misc Commands

Suppose you want to see the pods that are running: 
`kubectl get pods -A` 


## References 

- [Dashboard Releases](https://github.com/kubernetes/dashboard/releases)