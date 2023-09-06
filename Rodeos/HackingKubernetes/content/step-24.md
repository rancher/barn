+++
title = "Installing Kubewarden"
weight = 26
+++

We will now install Kubewarden onto our `Victim01` Kubernetes cluster. The following command will add `kubewarden` as a helm repository.

**Run the following commands on the victim01 VM.**

```ctr
helm repo add kubewarden https://charts.kubewarden.io
```

Next, we can install Kubewarden using `helm install` command. We will install three helm charts.

```ctr
helm install --create-namespace -n kubewarden kubewarden-crds kubewarden/kubewarden-crds
```

```ctr
helm install --wait -n kubewarden kubewarden-controller kubewarden/kubewarden-controller
```

```ctr
helm install --wait -n kubewarden kubewarden-defaults kubewarden/kubewarden-defaults
```

This will install kubewarden-crds, kubewarden-controller, and a default PolicyServer on the Kubernetes cluster in the default configuration (which includes self-signed TLS certs).

Now we need to install the kwctl cmd tool to pull the policies from the a artifacthub.io 

```ctr
wget https://github.com/kubewarden/kwctl/releases/download/v1.7.0-rc2/default.kwctl-linux-x86_64.kwctl-linux-x86_64.zip
unzip default.kwctl-linux-x86_64.kwctl-linux-x86_64.zip
```

For a easy usage we copy the binary into the `/usr/bin directory`
```ctr
cp kwctl-linux-x86_64 /usr/bin/kwctl
```