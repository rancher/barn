+++
title = "Discover learned processes and network connections after attack"
weight = 18
+++

Now let's see again what NeuVector learned about our app.

Open the app in the browser again: [http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io](http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io).

Then go to **Policy > Groups** and select the **nv.sample-app.default** group.

Check the process profile rules and network rules that have been learned.
