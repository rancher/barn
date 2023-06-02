+++
title = "Install Helm"
weight = 4
+++

Installing NeuVector into our new Kubernetes cluster is easily done with Helm. Helm is a very popular package manager for Kubernetes. It is used as the installation tool for NeuVector when deploying NeuVector onto a Kubernetes cluster. In order to use Helm, we have to download the Helm CLI.

```ctr:Kubernetes01
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  | bash
```

After a successful installation of Helm, we should check our installation to ensure that we are ready to install NeuVector.

```ctr:Kubernetes01
helm version --client --short
```

Helm uses the same kubeconfig as kubectl in the previous step.

We can check that this works by listing the Helm charts that are already installed in our cluster:

```ctr:Kubernetes01
helm ls --all-namespaces
```
