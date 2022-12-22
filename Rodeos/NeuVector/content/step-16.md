+++
title = "Add new behaviour"
weight = 16
+++

Let's learn some new behaviour.

First, check the checkbox in the groups list of the `nv.wordpress.wordpress` group and open the **Switch Mode** dialog.

There, turn off the **Zero Drift** mode by selecting **Basic** in the second line. **Zero Drift** mode automatically adds process execution and file access rules for all binaries and files inside a container. We want to enforce stricter rules for this demo.

Next, run `curl` inside of the WordPress container:

```ctr:kubernetes01
kubectl -n wordpress exec \
  $(kubectl get pods -n wordpress -l app.kubernetes.io/name=wordpress -o name) \
  -- curl -v https://suse.com
```

You can see that the request succeeds.

If you click **Refresh** in the NeuVector UI now, you can see that NeuVector added `curl` to list of allowed processes and that WordPress is allowed to connect to external systems.
