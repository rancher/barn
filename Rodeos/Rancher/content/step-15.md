+++
title = "Create a Kubernetes Ingress"
weight = 15
+++

In this step, we will be creating a Layer 7 ingress to access the workload we just deployed in the previous step. For this example, we will be using [sslip.io](http://sslip.io/) as a way to provide a DNS hostname for our workload. Rancher will automatically generate a corresponding workload IP.

1. In the left menu under **Service Discovery** go to **Ingresses** and click on **Create*.
2. Enter the following criteria:
    - **Name** - `helloworld`
    - **Request Host** - `helloworld.${vminfo:Cluster01:public_ip}.sslip.io`
    - **Path Prefix** - `/`
    - **Target Service** - Choose the `helloworld-nodeport` service from the dropdown
    - **Port** - Choose port `80` from the dropdown
3. Click **Create** and wait for the `helloworld.${vminfo:Cluster01:public_ip}.sslip.io` hostname to register, you should see the rule become **Active** within a few minutes.
4. Click on the hostname and browse to the workload.

**Note:** You may receive transient 404/502/503 errors while the workload stabilizes. This is due to the fact that we did not set a proper readiness probe on the workload, so Kubernetes is simply assuming the workload is healthy.
