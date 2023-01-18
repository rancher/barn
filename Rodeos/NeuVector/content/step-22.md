+++
title = "Un-quarantine Wordpress pod"
weight = 22
+++

The network activity graph not only visualizes you cluster, it also gives you quick access to change the NeuVector configuration.

If you right-click (double tap) on the WordPress Pod, a context menu appears which offers various functionality like displaying additional pod details or switching the mode in NeuVector.

You can also un-quarantine the WordPress pod from here. After you have un-quarantined it, the red circle disappears.

Meanwhile, the WordPress pod very likely crashed because it could not connect to its database anymore.

To force the port to restart without waiting for Kubernetes back-off time, you can delete the Pod:

```ctr:kubernetes01
kubectl delete pod -n wordpress -l app.kubernetes.io/name=wordpress
```

After a short while the WordPress Pod started and will be accessible again at [http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io](http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io).
