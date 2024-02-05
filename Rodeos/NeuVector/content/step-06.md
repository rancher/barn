+++
title = "Install NeuVector"
weight = 6
+++

We will now install NeuVector onto our `Kubernetes01` Kubernetes cluster. The following command will add `neuvector` as a helm repository.

```ctr:Kubernetes01
helm repo add neuvector https://neuvector.github.io/neuvector-helm/
```

Next, create a values file to configure the Helm installation:

```ctr:Kubernetes01
cat <<EOF > ~/neuvector-values.yaml
k3s:
  enabled: true
controller:
  replicas: 1
cve:
  scanner:
    replicas: 1
manager:
  ingress:
    enabled: true
    host: neuvector.${vminfo:kubernetes01:public_ip}.sslip.io
    annotations:
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
EOF
```

Finally, we can install NeuVector using our `helm install` command. (Note that the helm chart has a default version of NueVector. If desired, adding/chnaging the tag will install a different version.)

```ctr:Kubernetes01
helm install neuvector neuvector/core \
  --namespace neuvector \
  -f ~/neuvector-values.yaml \
  --version 2.7.2 \
  --create-namespace
```
