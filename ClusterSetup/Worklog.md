

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

Need to add this, fix namespaces
```
# docker login already done, and credential cached in ~/.docker/config.json
draft config set registry kkna2018reg.azurecr.io
helm init --tiller-namespace h --node-selectors "beta.kubernetes.io/os=linux" --service-account h-user

# draft up --tiller-namespace h
```

