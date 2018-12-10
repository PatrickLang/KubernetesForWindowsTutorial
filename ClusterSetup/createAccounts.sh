
function createNamespaceAndUser {
  cat serviceaccount.json | jq ".metadata.name"

    # kubectl create -f access.yaml
    # set userToken=`kubectl describe sa mynamespace-user -n mynamespace`
    # kubectl get secret $userToken -n mynamespace -o "jsonpath={.data.token}" | base64 -D
    # kubectl get secret mynamespace-user-token-xxxxx -n mynamespace -o "jsonpath={.data['ca\.crt']}" | base64 -D
    
}

