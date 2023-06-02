+++
title = "Create a Kubernetes cluster"
weight = 2
+++

NeuVector can run on any Kubernetes cluster and distribution, that is certified to be standard compliant by the Cloud Native Computing Foundation (CNCF).

For this Rodeo we will be using a [RKE2](https://rke2.io/) Kubernetes cluster. RKE2 is a powerful and fully standard compliant Kubernetes distribution, which is easy and fast to install and upgrade and is optimized for security.

In this Rodeo we want to create a single node Kubernetes cluster on the `Kubernetes01` VM in order to install NeuVector into it. This can be accomplished with the default RKE2 installation script:

```ctr:Kubernetes01
sudo bash -c 'curl -sfL https://get.rke2.io | \
  INSTALL_RKE2_CHANNEL="v1.23" \
  sh -'
```

After that you can enable and start the RKE2 systemd service:

```ctr:Kubernetes01
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
```

The service start will block until your cluster is up and running. This should take about 1 minute.

You can find more information on this in the [RKE2 documentation](https://docs.rke2.io/).
