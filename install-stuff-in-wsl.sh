cd /tmp
curl -L https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz | tar xvzf - linux-amd64/helm
curl -L https://azuredraft.blob.core.windows.net/draft/draft-v0.16.0-linux-amd64.tar.gz | tar xvzf - linux-amd64/draft
curl -L https://dl.k8s.io/v1.13.0/kubernetes-client-linux-amd64.tar.gz | tar xvzf -
sudo mv linux-amd64/* /usr/local/bin
sudo mv kubernetes/client/bin/kubectl /usr/local/bin/
cd ~