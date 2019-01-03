
## Setting up the cluster

For this lab, you'll need a Kubernetes cluster with at least 1 Linux node as a leader, 1 Linux agent node, and 1 Windows agent node. More agents are almost always better in case one fails. I used [aks-engine](https://aka.ms/windowscontainers/kubernetes) to set up 3 leader nodes, 2 Linux agents, and 8 Windows agents.

## Configuration done on cluster

### Creating a namespace per user


Here's a good summary of creating namespaces & kubeconfig:
https://jeremievallee.com/2018/05/28/kubernetes-rbac-namespace-user.html

I put similar steps into createAccounts.sh. Once you have a `KUBECONFIG` set (this could even be from a leader node), run `./createAccounts.sh N` where N is the number of accounts you wish to create. It will create N JSON files that can be used by different people in the workshop.


### Deploy nginx ingress

I didn't want people to wait on the Kubernetes (and therefore cloud provider) to create Load Balancer IPs for each deployment. Instead, I used a shared ingress controller. I just deployed this once on my cluster ahead of time, and set it up with a valid wildcard `*` DNS record.

See https://github.com/Azure/acs-engine/blob/master/docs/kubernetes/mixed-cluster-ingress.md for full details

```bash
helm install --name nginx-ingress \
    --set controller.nodeSelector."beta\.kubernetes\.io\/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io\/os"=linux \
    --set rbac.create=true \
    stable/nginx-ingress
```

## Configuration users need to do inside VMs

```
# get kubeconfig, write it to ~/.kube/config
# $ENV:TILLER_NAMESPACE="h"
# docker login already done, and credential cached in ~/.docker/config.json
draft config set registry kkna2018reg.azurecr.io
helm init --tiller-namespace h --node-selectors "beta.kubernetes.io/os=linux" --service-account h-user
```