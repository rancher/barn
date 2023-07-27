+++
title = "Cleanup"
weight = 9
+++

First let's restart the Pod to clean up all the modifications we did in the container:

**Run the following commands on the victim01 VM.**

```ctr
kubectl delete pod -n default -l app=sample-app
```

To prevent the attack, we are going to install NeuVector and cert-manager to secure the NeuVector UI with TLS.
