+++
title = "Switch Wordpress to monitor mode"
weight = 17
+++

To test the **Monitor** mode of NeuVector, select the `nv.wordpress.wordpress` group again, click on **Switch Mode** and select the **Monitor Mode**.

In the **Process Profile Rules** of the `nv.wordpress.wordpress` group, remove the rule for `curl`.

If you execute the same `curl` command again:

```ctr:kubernetes01
kubectl -n wordpress exec \
  $(kubectl get pods -n wordpress -l app.kubernetes.io/name=wordpress -o name) \
  -- curl -v https://suse.com
```

The command and request still succeed.

But, if you check **Notifications > Security Events**, you will see an alert that `curl` was executed inside the WordPress container.
