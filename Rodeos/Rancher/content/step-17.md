+++
title = "Add a new chart repository"
weight = 17
+++

The easiest way to install a complete WordPress into our cluster, is through the built-in Apps Marketplace. In addition to the Rancher and partner provided apps that are already available. You can add any other Helm repository and allow the installation of the Helm charts in there through the Rancher UI.

1. In the left menu go to **Apps & Marketplace** > **Chart repositories**
2. Click on **Create** in the top right
3. Enter the following details:
   - **Name** - `rodeo`
   - **Target** - Should be `http(s) URL`
   - **Index URL** - `https://rancher.github.io/rodeo`
4. Click on **Create**
5. Once the repository has been synchronized, go to **Apps & Marketplace** > **Charts**. There you will now see several new apps that you can install.
