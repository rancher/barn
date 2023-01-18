+++
title = "Deploy WordPress as a Stateful Application"
weight = 21
+++

In this step, we will be deploying WordPress as a stateful application in the Kubernetes cluster. This WordPress deployment will utilize the NFS storage we deployed in the previous step to store our mariadb data persistently.

1. From **Apps & Marketplace** > **Charts** install the **WordPress** app
2. In step 1 of the installation wizard, choose the `stateful-wordpress` namespace and give the installation the name `wordpress`
3. In step 2 of the installation wizard, set:
   - **WordPress' settings** > **WordPress password** - to a password of your choice
   - Enable **WordPress setting** > **WordPress Persistent Volume Enabled**
   - Enable **Database setting** > **MariaDB Persistent Volume Enabled**
   - **Services and Load Balancing** > **Hostname** - `stateful-wordpress.${vminfo:Cluster01:public_ip}.sslip.io`
4. Scroll to the bottom and click **Install**.
5. Once the installation is complete, navigate to **Service Discovery** > **Ingresses**. There you will see a new Ingress. Click on the URL to access WordPress.
    - *Note: You may receive **404**, **502**, or **503** errors while the WordPress app is coming up. Simply refresh the page occasionally until WordPress is available*
6. Note that you now have two Persistent Volumes available under **Storage** > **Persistent Volumes**
7. Log into WordPress using your set admin credentials - [http://stateful-wordpress.${vminfo:Cluster01:public_ip}.sslip.io/wp-admin](http://stateful-wordpress.${vminfo:Cluster01:public_ip}.sslip.io/wp-admin) and create a new blog post. If you delete the **wordpress-mariadb** pod or click **Redeploy** now, your post will not be lost.
