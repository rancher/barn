+++
title = "Deny socat on node"
weight = 20
+++

Let's forbid `whoami` to be executed on the node.

Go to **Policy > Groups** and choose the `nodes` group.

Under **Process Profile Rules**, click on **Actions** and **Add rule**:

* Process name: `whoami`
* Path: `/usr/bin/whoami`
* Action: Deny

Switch the mode of the `nodes` group to `Protect`.

Try to execute in the remote shell on the attacker02 VM

```ctr
whoami
```

The execution will be blocked. And you will have an alert under **Notifications > Security Events**.

Let's forbid `socat` to be executed on the node.

Under **Process Profile Rules**, click on **Actions** and **Add rule**:

* Process name: `socat`
* Path: `/usr/bin/socat`
* Action: Deny

Execute the socat payload in the remote shell on the attacker01 VM again

```ctr:
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
```

The execution will be blocked. And you will have an alert under **Notifications > Security Events**.
