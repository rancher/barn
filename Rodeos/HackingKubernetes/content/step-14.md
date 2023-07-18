+++
title = "Check Scan Results"
weight = 14
+++

Now let's check the results of the scans.

Navigating to **Assets -> Nodes** will show the underlying nodes for the cluster. In the vulnerability tab, you should see CVE `CVE-2022-0492`.

Navigating to **Assets -> Containers** will show the containers running on the cluster. In the vulnerability tab of the sample-app, you should see `CVE-2021-45046`.

You can click on each vulnerability name/CVE that is discovered to retrieve a description of it, and click on the inspect arrow in the popup to see the detailed description of the vulnerability.

More detail can be found here: [Scanning & Compliance](https://open-docs.neuvector.com/scanning/scanning)
