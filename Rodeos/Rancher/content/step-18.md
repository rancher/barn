+++
title = "Deploy a Wordpress as a Stateless Application"
weight = 18
+++

In this step, we will be deploying WordPress as a stateless application in the Kubernetes cluster.

1. From **Apps & Marketplace** > **Charts** install the **WordPress** app
2. In step 1 of the installation wizard, choose the `stateless-wordpress` namespace and give the installation the name `wordpress`
3. In step 2 of the installation wizard, set:
   - **WordPress' settings** > **WordPress password** - to a password of your choice
   - **Services and Load Balancing** > **Hostname** - `wordpress.${vminfo:Cluster01:public_ip}.sslip.io`
4. Scroll to the bottom and click **Install**.
5. Once the installation is complete, navigate to **Service Discovery** > **Ingresses**. There you will see a new Ingress. Click on the URL to access WordPress.
    - *Note: You may receive **404**, **502**, or **503** errors while the WordPress app is coming up. Simply refresh the page occasionally until WordPress is available*
6. Log into WordPress using your set admin credentials - [http://wordpress.${vminfo:Cluster01:public_ip}.sslip.io/wp-admin](http://wordpress.${vminfo:Cluster01:public_ip}.sslip.io/wp-admin), and create a new blog post. Note that if you delete the **wordpress-mariadb-0** pod or click **Redeploy** on the **wordpress-mariadb** StatefulSet you will lose your post. This is because there is no persistent storage under the WordPress MariaDB StatefulSet.
