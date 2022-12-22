+++
title = "Verify Rancher is Ready to Access"
weight = 7
+++

Before we access Rancher, we need to make sure that `cert-manager` has signed a certificate using the `dynamiclistener-ca` in order to make sure our connection to Rancher does not get interrupted. The following bash script will check for the certificate we are looking for.

```ctr:Rancher01
while true; do curl -kv https://rancher.${vminfo:Rancher01:public_ip}.sslip.io 2>&1 | grep -q "dynamiclistener-ca"; if [ $? != 0 ]; then echo "Rancher isn't ready yet"; sleep 5; continue; fi; break; done; echo "Rancher is Ready";
```
