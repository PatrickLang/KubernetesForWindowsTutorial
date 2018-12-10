

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