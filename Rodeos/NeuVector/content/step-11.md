+++
title = "Add scanning for a container registry"
weight = 11
+++

Now, let's configure a set of registry scans. This feature can run periodic scans of public or private registries.

Navigate to **Assets -> Registries** and click "Add" and use the following example values to add 2 registries:

* Name: docker-example
* Registry: `https://registry.hub.docker.com`
* Filter: elastic/logstash:7.13.3
* Rescan after CVE: yes
* Scan Layers: yes
* Periodic: no


* Name: nv-demo
* Name: nv-demo
* Registry: `https://registry.hub.docker.com`
* Filter: nvbeta/*
* Rescan after CVE: yes
* Scan Layers: yes
* Periodic: no

For each registry entry, click the **Start Scan** button to initiate a scan.

Explore the scan results by clicking one of the images scanned. Here you will see the vulnerabilities by layer, including the corresponding Dockerfile section.
