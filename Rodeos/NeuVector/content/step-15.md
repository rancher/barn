+++
title = "Show learned rules of Wordpress"
weight = 15
+++

NeuVector can automatically learn the standard behaviour of your applications and build up a ruleset to use in a zero trust manner. The platform will only allow the execution of specific process and access to specific files inside each container as well as limit the network connections to and from it.

Each Pod can be in one of three modes:

* **Discover** to learn the behaviour and automatically built up a ruleset
* **Monitor** to alert, but not block behaviour that is not covered by rules
* **Protect** to alert and block behaviour that is not covered by rules

Of course, you can also manually add, edit and remove rules or configure them via GitOps.

By default, every new Pod is in **Discover** mode first. But this can also be configured differently.

Let's check out the learned rules for the previously deployed WordPress Pod.

Go to **Policy > Groups** and search for the **nv.wordpress.wordpress** group.

In the **Members** tab, you can see that there's one Pod with one container in this group.

The **Process profile rules** tab shows you a list of all learned process rules that should be allowed.

The **Network Rules** tab shows you a list of all incoming and outgoing network connections that should be allowed as well as the protocol that should be used on each connection.
