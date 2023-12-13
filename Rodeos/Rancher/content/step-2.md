+++
title = "Create a Kubernetes cluster for Rancher"
weight = 2
+++

Rancher can run on any Kubernetes cluster and distribution, that is certified to be standard compliant by the Cloud Native Computing Foundation (CNCF).

We recommend using a [RKE2](https://rke2.io/) Kubernetes cluster. RKE2 is a CNCF certified Kubernetes distribution, which is easy and fast to install and upgrade with a focus on security. You can run it in your datacenter, in the cloud as well as on edge devices. It works great on a single-node as well in large, highly available setups.

In this Rodeo we want to create a single node Kubernetes cluster on the `Rancher01` VM in order to install Rancher into it. This can be accomplished with the default RKE2 installation script:

```ctr:Rancher01
sudo bash -c 'curl -sfL https://get.rke2.io | \
  INSTALL_RKE2_CHANNEL="v1.26" \
  sh -'
```

Create a configuration for RKE2

```ctr:Rancher01
sudo mkdir -p /etc/rancher/rke2
sudo bash -c 'echo "write-kubeconfig-mode: \"0644\"" > /etc/rancher/rke2/config.yaml'
```

After that you can enable and start the RKE2 systemd service:

```ctr:Rancher01
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
```

The service start will block until your cluster is up and running. This should take about 1 minute.

You can access the RKE2 logs with:

```ctr:Rancher01
sudo journalctl -u rke2-server
```

Creating a highly available, multi-node Kubernetes cluster for a highly available Rancher installation would not be much more complicated. You can run the same installation script with a couple more options on multiple nodes.

You can find more information on this in the [RKE2 documentation](https://docs.rke2.io/).
