+++
title = "Deploy the nfs-server-provisioner into your Kubernetes Cluster"
weight = 19
+++

In a Kubernetes Cluster, it can be desirable to have persistent storage available for applications to use. As we do not have a Kubernetes Cloud Provider enabled in this cluster, we will be deploying the **nfs-server-provisioner** which will run an NFS server inside our Kubernetes cluster for persistent storage. This is not a production-ready solution by any means, but helps to illustrate the persistent storage constructs.

1. From **Apps & Marketplace** > **Charts** install the **nfs-server-provisioner** app
2. In step 1 of the installation wizard, choose the `kube-system` namespace and give the installation the name `nfs-server-provisioner`
3. In step 2 of the installation wizard, you can keep all the settings as default.
4. Scroll to the bottom and click **Install**.
5. Once the app is installed, go to **Storage** > **Storage Classes**
6. Observe the `nfs` storage class and the checkmark next to it which indicates it is the **Default** storage class.
