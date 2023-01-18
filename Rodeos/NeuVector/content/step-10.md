+++
title = "Check Scan Results"
weight = 10
+++

Now let's check the results of the scans.

Go back to the NeuVector UI at [https://neuvector.${vminfo:Kubernetes01:public_ip}.sslip.io](https://neuvector.${vminfo:Kubernetes01:public_ip}.sslip.io).

Navigating to **Assets -> Platforms** will show the kubernetes cluster itself, and any compliance issues.

Navigating to **Assets -> Nodes** will show the underlying nodes for the cluster.

Navigating to **Assets -> Containers** will show the containers running on the cluster.

The **Details** tab will show data describing the selected object.

The **Compliance** tab will show results of various configuration items, along with remediation guidance by clicking on the lightbulb icon.

The **Vulnerabilities** tab will show the results of the scans against the current CVE database, listing fixed versions where applicable.

You can click on each vulnerability name/CVE that is discovered to retrieve a description of it, and click on the inspect arrow in the popup to see the detailed description of the vulnerability.

More detail can be found here: [Scanning & Compliance](https://open-docs.neuvector.com/scanning/scanning)
