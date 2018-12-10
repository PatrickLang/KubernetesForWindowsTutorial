

## Creating a namespace per user


Good summary of creating namespaces & kubeconfig

https://jeremievallee.com/2018/05/28/kubernetes-rbac-namespace-user.html


Steps needed

```
for (i=0;i<100;i++) {
    Create namespace
    Add pull secrets to it
    Create service account, role, rolebinding
    Create kubeconfig
}
```

## Configuration done on cluster

### Deploy nginx ingress

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
# get kubeconfig, set KUBECONFIG variable
# $ENV:TILLER_NAMESPACE="h"
# docker login already done, and credential cached in ~/.docker/config.json
draft config set registry kkna2018reg.azurecr.io
helm init --tiller-namespace h --node-selectors "beta.kubernetes.io/os=linux" --service-account h-user

# draft up --tiller-namespace h
```

