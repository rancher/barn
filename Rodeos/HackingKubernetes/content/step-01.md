+++
title = "Introduction"
weight = 1
+++

Welcome to the Workshop "Hacking Kubernetes".

In this scenario, we will create a Kubernetes cluster and deploy a sample application. The OS and the sample application will have multiple vulnerabilities.

We will exploit these vulnerabilities to become root on the host OS and admin in the Kubernetes cluster.

After that, we will explore how we can protect ourselves against this and other attacks without patching the vulnerabilities.

We will be using two virtual machines today, `victim01`, `attacker01` and `attacker02` which are located in the tabs in the panel to the right. `victim01` will run a Kubernetes cluster and the sample app. `attacker01` and `attacker02` will be the VMs of the attacker and receive a remote shell.
