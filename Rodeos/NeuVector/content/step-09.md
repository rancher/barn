+++
title = "Deploy WordPress test app"
weight = 9
+++

As a test workload we are going to deploy a WordPress into the cluster.

Note, that this WordPress is not highly available and is not configured with persistent storage. You should not run this Helm chart in production.

First, we'll add the helm repository for WordPress

```ctr:Kubernetes01
helm repo add rodeo https://rancher.github.io/rodeo
```

Now, we can install WordPress

```ctr:Kubernetes01
helm install \
  wordpress rodeo/wordpress \
  --namespace wordpress \
  --set wordpress.ingress.hostname=wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io \
  --create-namespace
```

Wait until the WordPress Pods are up and running. This can often take upwards of 2 minutes.

```ctr:Kubernetes01
kubectl get pods -n wordpress
```

After that you will be able to access WordPress at [http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io](http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io).
