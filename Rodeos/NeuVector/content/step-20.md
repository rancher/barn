+++
title = "Add and test response rule to Wordpress"
weight = 20
+++

NeuVector can automatically react on violations, attack or discovered CVEs with [response rules](https://open-docs.neuvector.com/policy/responserules).

In this step we want to create a response rule, which automatically quarantines the Pod when a network rule violation is discovered.

* Go to **Policy > Response Rules**
* Add a new response rule below the last existing response rule entry
* Group: **nv.wordpress.wordpress**
* Category: **Security Event**
* Criteria: **name:Network.Violation**
* Action: **Quarantine**
* Status: **Enabled**

After adding the response rule, execute the curl request inside the WordPress container again:

```ctr:kubernetes01
kubectl -n wordpress exec \
  $(kubectl get pods -n wordpress -l app.kubernetes.io/name=wordpress -o name) \
  -- curl -v https://suse.com
```

The request will still fail, but now NeuVector has automatically quarantined the WordPress Pod so that no incoming or outgoing traffic is allowed.

You can see this under **Policy > Groups** in the `nv.wordpress.wordpress` group in the **Members** tab.

Also, a request to [http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io](http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io) will result in an HTTP 503 or 502 error because the ingress controller can't reach the Pod anymore.

To clean up, go back to **Policy > Response Rules** and remove the rule that was just created.
