+++
title = "Creating Projects in your Kubernetes Cluster"
weight = 16
+++

A project is a grouping of one or more Kubernetes namespaces. In this step, we will create an example project and use it to deploy a stateless WordPress.

1. In the left menu go to **Cluster** > **Projects/Namespaces**
2. Click **Create Project** in the top right
3. Give your project a name, like `stateless-wordpress`
    - Note the ability to add members, set resource quotas and a pod security policy for this project.
4. Next create a new namespace in the `stateless-wordpress` project. In the list of all **Projects/Namespaces**, scroll down to the `stateless-wordpress` project and click the **Create Namespace** button.
5. Enter the **Name** `stateless-wordpress` and click **Create**.
