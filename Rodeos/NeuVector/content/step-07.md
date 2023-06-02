+++
title = "Accessing NeuVector"
weight = 7
+++

***Note:*** NeuVector may not immediately be available at the link below, as it may be starting up still. Please continue to refresh until NeuVector is available.

First wait until all NeuVector Pods are up and running

```ctr:Kubernetes01
kubectl get pods -n cattle-neuvector-system
```

1. Access NeuVector at [https://neuvector.${vminfo:Kubernetes01:public_ip}.sslip.io](https://neuvector.${vminfo:Kubernetes01:public_ip}.sslip.io).
2. For this Rodeo, NeuVector is installed with a self-signed certificate from a CA that is not automatically trusted by your browser. Because of this, you will see a certificate warning in your browser. You can safely skip this warning. Some Chromium based browsers may not show a skip button. If this is the case, just click anywhere on the error page and type "thisisunsafe" (without quotes). This will force the browser to bypass the warning and accept the certificate.
3. Log in with the username "admin" and the default password "admin"
4. Make sure to agree to the Terms & Conditions
