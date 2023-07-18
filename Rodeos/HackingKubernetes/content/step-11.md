+++
title = "Install NeuVector"
weight = 11
+++

We will now install NeuVector onto our `Victim01` Kubernetes cluster. The following command will add `neuvector` as a helm repository.

Run the following commands on the victim01 VM.

```ctr
helm repo add neuvector https://neuvector.github.io/neuvector-helm/
```

In order to automatically generate a selfsigned TLS certificate for NeuVector, we have to configure a ClusterIssuer in cert-manager, that the NeuVector helm chart can reference:

```ctr
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: selfsigned-cluster-issuer
spec:
  selfSigned: {}
EOF
```  
  
You can find more information in the [cert-manager docs](https://cert-manager.io/docs/).  

Next, create a values file to configure the Helm installation:

```ctr
cat <<EOF > ~/neuvector-values.yaml
controller:
  replicas: 1
cve:
  scanner:
    replicas: 1
manager:
  ingress:
    enabled: true
    host: neuvector.cattle-neuvector-system.${vminfo:victim01:public_ip}.sslip.io
    annotations:
      cert-manager.io/cluster-issuer: selfsigned-cluster-issuer
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    tls: true
    secretName: neuvector-tls-secret
EOF
```

Finally, we can install NeuVector using our `helm install` command.

```ctr
helm install neuvector neuvector/core \
  --namespace cattle-neuvector-system \
  -f ~/neuvector-values.yaml \
  --version 2.6.0 \
  --create-namespace
```
