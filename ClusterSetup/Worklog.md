

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
draft config set registry kkna2018reg.azurecr.io
helm init --tiller-namespace h --node-selectors "beta.kubernetes.io/os=linux"
```

```
helm list --tiller-namespace h
Error: configmaps is forbidden: User "system:serviceaccount:h:default" cannot list resource "configmaps" in API group "" in the namespace "h"
```

