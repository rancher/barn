+++
title = "Install Helm"
weight = 4
+++

Installing Rancher into our new Kubernetes cluster is easily done with Helm. Helm is a very popular package manager for Kubernetes. It is used as the installation tool for Rancher when deploying Rancher onto a Kubernetes cluster. In order to use Helm, we have to download the Helm CLI.

```ctr:Rancher01
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  | bash
```

After a successful installation of Helm, we should check our installation to ensure that we are ready to install Rancher.

```ctr:Rancher01
helm version --client
```

Helm uses the same kubeconfig as kubectl in the previous step.

We can check that this works by listing the Helm charts that are already installed in our cluster:

```ctr:Rancher01
helm ls --all-namespaces
```
