+++
title = "Enable Rancher Monitoring"
weight = 12
+++

To deploy the _Rancher Monitoring_ feature:

1. Navigate to **Apps & Marketplace.** in the left menu
2. Under **Charts** Locate the **Monitoring** chart, and click on it
3. On the Monitoring App Detail page click the **Install** button in the top right
4. This leads you to the installation wizard. In the first **Metadata** step, we can leave everything as default and click **Next**.
5. In the **Values** step, select the **Prometheus** section on the left. Change **Resource Limits** > **Requested CPU** from `750m` to `250m` and **Requested Memory** from `750Mi` to `250Mi`. This is required because our scenario virtual machine has limited CPU and memory available.
6. Click "Install" at the bottom of the page, and wait for the `helm` install operation to complete.

Once Monitoring has been installed, you can click on that application under "Installed Apps" to view the various resources that were deployed.
