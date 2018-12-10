
function createNamespaceAndUser {
  set -x
  ns=$1
  echo Creating new namespace $ns
  kubectl create ns $ns
  cat serviceaccount.json | jq ".metadata.name = \"$ns-user\"" | jq ".metadata.namespace = \"$ns\"" | kubectl create -f -
  cat role.json | jq ".metadata.name = \"$ns-user-full-access\"" | jq ".metadata.namespace = \"$ns\"" | kubectl create -f -
  cat binding.json | jq ".metadata.name = \"$ns-user-binding\"" | \
      jq ".metadata.namespace = \"$ns\"" | \
      jq ".subjects[0].name = \"$ns-user\"" | \
      jq ".subjects[0].namespace = \"$ns\"" | \
      jq ".roleRef.name = \"$ns-user-full-access\"" | kubectl create -f -
  userSecret=$(kubectl get sa $ns-user -n $ns -o json | jq .secrets[0].name | sed s/\"//g )
  userToken=$(kubectl get secret $userSecret -n $ns -o "jsonpath={.data.token}" | base64 -d)
  caCert=$(kubectl get secret $userSecret -n $ns -o "jsonpath={.data['ca\.crt']}" | base64 -d)
  currentServer=$(cat $KUBECONFIG | jq .clusters[0].cluster.server | sed s/\"//g)
  currentCluster=$(cat $KUBECONFIG | jq .clusters[0].name | sed s/\"//g)
  cat kubeconfigTemplate.yaml | \
    yq ".clusters[0].cluster.\"certificate-authority-data\" = \"$caCert\"" | \
    jq ".clusters[0].cluster.server = \"$currentServer\"" | \
    jq ".clusters[0].name = \"$currentCluster\"" | \
    jq ".users[0].name = \"$ns-user\"" | \
    jq ".users[0].user.\"client-key-data\" = \"$caCert\"" | \
    jq ".users[0].user.token = \"$userToken\"" | \
    jq ".contexts[0].context.namespace = \"$ns\"" | \
    jq ".contexts[0].context.cluster = \"$currentCluster\"" | \
    jq ".contexts[0].context.user = \"$ns-user\"" | \
    jq ".contexts[0].name = \"$ns\"" | \
    jq ".\"current-context\" = \"$ns\"" > $ns-user.json
}

