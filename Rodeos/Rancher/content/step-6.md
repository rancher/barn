+++
title = "Install Rancher"
weight = 6
+++

We will now install Rancher onto our `Rancher01` Kubernetes cluster. The following command will add `rancher-stable` as a helm repository and update the local Helm chart repository cache.

```ctr:Rancher01
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update
```

Finally, we can install Rancher using our `helm install` command.

```ctr:Rancher01
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.${vminfo:rancher01:public_ip}.sslip.io \
  --set replicas=1 \
  --set bootstrapPassword=RancherOnRKE2 \
  --version 2.7.9 \
  --create-namespace
```
