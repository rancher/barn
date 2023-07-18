+++
title = "Create a Kubernetes cluster"
weight = 3
+++

Next, lets create a Kubernetes cluster using the RKE1 distribution.

Run the following commands on the victim01 VM.

To start out, we will generate a new SSH Keypair and place this keypair on the node we will install Kubernetes onto. As we will be using the `victim01` node to run Kubernetes, we will simply copy the public key into the `authorized_keys` file of this node.

The following command will generate the keypair and copy it into the file.

```ctr
ssh-keygen -b 2048 -t rsa -f \
/home/ubuntu/.ssh/id_rsa -N ""
cat /home/ubuntu/.ssh/id_rsa.pub \
>> /home/ubuntu/.ssh/authorized_keys
```

RKE1 uses a command line tool to provision a cluster on remote hosts. Let's install this tool:

```ctr
wget https://github.com/rancher/rke/releases/download/v1.4.7/rke_linux-amd64
sudo mv rke_linux-amd64 /usr/local/bin/rke
chmod +x /usr/local/bin/rke
```

We now need to configure where and with which configuration our cluster should be created:

```ctr
cat <<EOF > ~/cluster.yml
nodes:
  - address: ${vminfo:victim01:public_ip}
    user: ubuntu
    role:
      - controlplane
      - etcd
      - worker
kubernetes_version: v1.23.16-rancher2-3   
EOF
```

To deploy the Kubernetes cluster, run

```ctr
rke up --config ~/cluster.yml
```
