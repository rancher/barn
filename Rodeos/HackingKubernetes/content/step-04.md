+++
title = "Testing your cluster"
weight = 4
+++

RKE1 now created a new Kubernetes cluster. In order to interact with its API, we can use the Kubernetes CLI `kubectl`.

Run the following commands on the victim01 VM.

To install `kubectl` run:

```ctr
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

We also have to ensure that `kubectl` can connect to our Kubernetes cluster. For this, `kubectl` uses standard Kubeconfig files which it looks for in a `KUBECONFIG` environment variable or in a `~/.kube/config` file in the user's home directory.

RKE will have generated two important files:

* `kube_config_cluster.yml`
* `cluster.clusterstate`

All of these files are extremely important for future maintenance of our cluster. When running `rke` on your own machines to install Kubernetes/Rancher, you must make sure you have current copies of all 3 files otherwise you can run into errors when running `rke up`.

The `kube_config_cluster.yml` file will contain a `kube-admin` kubernetes context that can be used to interact with your Kubernetes cluster that you've installed Rancher on.

We can copy the `kube_config_cluster.yml` file to our `/home/ubuntu/.kube/config` file so that `kubectl` can interact with our cluster:

```ctr
mkdir -p ~/.kube
sudo cp ~/kube_config_cluster.yml ~/.kube/config
sudo chown ubuntu: ~/.kube/config
```

In order to test that we can properly interact with our cluster, we can execute two commands.

To list all the nodes in the cluster and check their status:

```ctr
kubectl get nodes
```

The cluster should have one node, and the status should be "Ready".

To list all the Pods in all Namespaces of the cluster:

```ctr
kubectl get pods --all-namespaces
```

All Pods other than helm should have the status "Running".
