+++
title = "Switch Wordpress to protect mode"
weight = 18
+++

To test the **Protect** mode of NeuVector, go back to **Policy > Groups**, select the `nv.wordpress.wordpress` group again, click on **Switch Mode** and select the **Protect** mode.

If you execute the same `curl` command again:

```ctr:kubernetes01
kubectl -n wordpress exec \
  $(kubectl get pods -n wordpress -l app.kubernetes.io/name=wordpress -o name) \
  -- curl -v https://suse.com
```

The command execution is now blocked.

If you check **Notifications > Security Events**, you will see an alert that `curl` blocked inside the WordPress container.

In order to quickly deploy a rule to allow the execution, click on **Review Rule** in the alert, and deploy a rule that allows this action.

If you execute `curl` again:

```ctr:kubernetes01
kubectl -n wordpress exec \
  $(kubectl get pods -n wordpress -l app.kubernetes.io/name=wordpress -o name) \
  -- curl -v https://suse.com
```

The execution will now succeed.

Next, lets remove the network rule that allows the connection to an external system.

Go to **Policy > Network Rules** and delete the rule that allows a connection from **nv.wordpress.wordpress** to **external**.

Don't forget to save the changes.

If you execute `curl` again:

```ctr:kubernetes01
kubectl -n wordpress exec \
  $(kubectl get pods -n wordpress -l app.kubernetes.io/name=wordpress -o name) \
  -- curl -v https://suse.com
```

You can see that the execution of the `curl` process works, but the network connection is blocked and will time out.

This is also visible as an alert under **Notifications > Security Events**
