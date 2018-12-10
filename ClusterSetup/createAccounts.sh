
function createNamespaceAndUser {
  ns=$1
  echo Creating new namespace $ns
  cat serviceaccount.json | jq ".metadata.name = \"$ns-user\"" | jq ".metadata.namespace = \"$ns\""
  cat role.json | jq ".metadata.name = \"$ns-user-full-access\"" | jq ".metadata.namespace = \"$ns\""
  cat binding.json | jq ".metadata.name = \"$ns-user-binding\"" | \
      jq ".metadata.namespace = \"$ns\"" | \
      jq ".subjects[0].name = \"$ns-user\"" | \
      jq ".subjects[0].namespace = \"$ns\"" | \
      jq ".roleRef.name = \"$ns-user-full-access\""
    # kubectl create -f access.yaml
    # set userToken=`kubectl describe sa mynamespace-user -n mynamespace`
    # kubectl get secret $userToken -n mynamespace -o "jsonpath={.data.token}" | base64 -D
    # kubectl get secret mynamespace-user-token-xxxxx -n mynamespace -o "jsonpath={.data['ca\.crt']}" | base64 -D
    
}

