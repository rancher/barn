+++
title = "Install Rancher"
weight = 6
+++

We will now install Rancher onto our `Rancher01` Kubernetes cluster. The following command will add `rancher-latest` as a helm repository.

```ctr:Rancher01
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
```

Finally, we can install Rancher using our `helm install` command.

```ctr:Rancher01
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.${vminfo:rancher01:public_ip}.sslip.io \
  --set replicas=1 \
  --set bootstrapPassword=RancherOnRKE2 \
  --version 2.7.4 \
  --create-namespace
```
